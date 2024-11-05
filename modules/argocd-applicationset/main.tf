locals {
  # Extract the repo URL without the path and ref
  applications_repo_url = regex("(^https?:\\/\\/.*?)(\\/\\/|$|\\?)", var.argo_applications_repourl)[0]

  # Extract the path (or default to "applications.yaml" if missing)
  applications_path = try(regex("(\\/\\/).*?(\\/\\/)([^?]+)", var.argo_applications_repourl)[2], "applications.yaml")

  # Extract the ref (or default to "main" if missing)
  applications_revision = try(regex("ref=([^&]+)", var.argo_applications_repourl)[0], "main")

}
resource "time_sleep" "wait_time" {
  depends_on = [var.pre_reqs, var.argocd_helm_release_metadata]

  destroy_duration = var.sleep_time
}

resource "helm_release" "application_set" {
  name       = "${var.name}-application-set"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "1.6.2"

  timeout = 300

  # TODO: Reformat to set and values
  # TODO: Switch to Github App auth: https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/Generators-SCM-Provider/#github
  namespace = var.argo_application_set_helm_release_namespace
  values = [<<EOF
applicationsets:
  - name: "${var.name}"
    goTemplate: true
    goTemplateOptions:
      - missingkey=error
    %{if var.allow_disable_sync}
    ignoreApplicationDifferences:
    - jsonPointers:
      - /spec/syncPolicy
    %{endif}
    syncPolicy:
      preserveResourcesOnDeletion: false
    generators:
    - matrix:
        generators:
        - git:
            repoURL: "${local.applications_repo_url}"
            revision: "${local.applications_revision}"
            files:
              - path: "${local.applications_path}"
        - list:
            elements: []
            elementsYaml: "{{ .applications | toJson }}"
    template:
      metadata:
        name: "{{ .name }}"
        annotations:
        %{if var.argo_notifications_ms_teams_secret_name != ""}
          notifications.argoproj.io/subscribe.on-created.teams-workflow: ""
          notifications.argoproj.io/subscribe.on-deleted.teams-workflow: ""
          notifications.argoproj.io/subscribe.on-deployed.teams-workflow: ""
          notifications.argoproj.io/subscribe.on-health-degraded.teams-workflow: ""
          notifications.argoproj.io/subscribe.on-sync-failed.teams-workflow: ""
          notifications.argoproj.io/subscribe.on-sync-running.teams-workflow: ""
          notifications.argoproj.io/subscribe.on-sync-status-unknown.teams-workflow: ""
          notifications.argoproj.io/subscribe.on-sync-status-outofsync.teams-workflow: ""
          notifications.argoproj.io/subscribe.on-sync-succeeded.teams-workflow: ""
        %{endif}
      spec:
        project: ${var.argo_project_name}
        source:
          repoURL: "{{ .source.repoURL }}"
          targetRevision: "{{ .source.targetRevision }}"
          path: "{{ .source.path }}"
        destination:
          server: https://kubernetes.default.svc
          namespace: "{{ .namespace }}"
        syncPolicy:
          automated:
            selfHeal: true
          retry:
            backoff:
              duration: 30s
              factor: 2
              maxDuration: 2m
            limit: 5
    %{if length(var.patches) > 0}
    templatePatch: |
      spec:
        source:
          kustomize:
            patches:
              %{for patch in var.patches}
              - target:
                  %{if patch.version != null}version: ${patch.version}%{endif}
                  kind: ${patch.kind}
                  name: ${patch.name}
                patch: |-
                  %{for op in patch.operations}
                  - op: ${op.op}
                    path: ${op.path}
                    value: ${op.value}
                  %{endfor}
            %{endfor}
    %{endif}
EOF
  ]

  depends_on = [var.pre_reqs, var.argocd_helm_release_metadata, time_sleep.wait_time]
}
