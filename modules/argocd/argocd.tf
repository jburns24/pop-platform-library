data "aws_secretsmanager_secret" "github_app_sso_config_secret" {
  name = var.argo_github_app_sso_secret_name
}

data "aws_secretsmanager_secret_version" "github_app_sso_config_secret" {
  secret_id = data.aws_secretsmanager_secret.github_app_sso_config_secret.id
}


data "aws_secretsmanager_secret" "argo_notifications_ms_teams_secret" {
  count = var.argo_notifications_ms_teams_secret_name != "" ? 1 : 0
  name  = var.argo_notifications_ms_teams_secret_name
}

data "aws_secretsmanager_secret_version" "argo_notifications_ms_teams_secret_version" {
  count     = var.argo_notifications_ms_teams_secret_name != "" ? 1 : 0
  secret_id = data.aws_secretsmanager_secret.argo_notifications_ms_teams_secret[0].id
}

resource "kubernetes_secret" "argo_dex_secret" {
  type = "Opaque"
  metadata {
    name      = "argocd-dex-secret"
    namespace = kubernetes_namespace.argocd.id
    labels = {
      "app.kubernetes.io/name" : "argocd-dex-secret",
      "app.kubernetes.io/part-of" : "argocd"
    }
  }
  data = {
    #TODO: update code to use interpolation proper interpolation syntax
    #tflint-ignore: terraform_deprecated_interpolation
    client_id = "${jsondecode(data.aws_secretsmanager_secret_version.github_app_sso_config_secret.secret_string)["client_id"]}"
    #TODO: update code to use interpolation proper interpolation syntax
    #tflint-ignore: terraform_deprecated_interpolation
    client_secret = "${jsondecode(data.aws_secretsmanager_secret_version.github_app_sso_config_secret.secret_string)["client_secret"]}"
  }
}

resource "kubernetes_secret" "argo_notifications_ms_teams" {
  count = var.argo_notifications_ms_teams_secret_name != "" ? 1 : 0
  type  = "Opaque"
  metadata {
    name      = "argocd-notifications-secret"
    namespace = kubernetes_namespace.argocd.id
    labels = {
      "app.kubernetes.io/name" : "argocd-notifications-secret",
      "app.kubernetes.io/part-of" : "argocd"
    }
  }
  data = {
    #TODO: update code to use interpolation proper interpolation syntax
    #tflint-ignore: terraform_deprecated_interpolation
    ms_teams_webhook = "${jsondecode(data.aws_secretsmanager_secret_version.argo_notifications_ms_teams_secret_version[0].secret_string)["ms_teams_webhook"]}"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }

  #trivy:ignore:avd-aws-0057
  depends_on = [var.pre_reqs, var.eks_cluster_arn, module.aws_iam_role_argocd, module.aws_iam_policy_argocd_policy, var.albc_helm_release_metadata]
}

# https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.6.8"

  timeout = 300

  namespace = kubernetes_namespace.argocd.id
  #trivy:ignore:avd-aws-0057
  depends_on = [var.pre_reqs, kubernetes_namespace.argocd, module.aws_iam_role_argocd, module.aws_iam_policy_argocd_policy, var.albc_helm_release_metadata]

  #Helm Values
  # https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/values.yaml

  values = [<<EOF
redis-ha:
  enabled: ${var.redis_ha_enabled}
  replicas: ${var.redis_ha_replicas}
  haproxy:
    replicas: ${var.redis_ha_replicas}
controller:
  metrics:
    enabled: true
  replicas: ${var.controller_replicas}
repoServer:
  metrics:
    enabled: true
  replicas: ${var.reposerver_replicas}
applicationSet:
  metrics:
    enabled: true
  replicas: ${var.applicationset_replicas}
notifications:
  cm:
    create: false
  secret:
    create: false
  logLevel: debug
server:
  replicas: ${var.server_replicas}
  serviceAccount:
    annotations:
      eks.amazonaws.com/role-arn: ${module.aws_iam_role_argocd.iam_role_arn}
  metrics:
    enabled: true
  ingress:
    enabled: true
    controller: generic
    annotations:
      alb.ingress.kubernetes.io/backend-protocol: HTTPS
      alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS": 443}]'
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/target-type: ip
      kubernetes.io/ingress.class: alb
    tls: true
configs:
  cm:
    exec.enabled: true
    kustomize.buildOptions: --enable-helm
  credentialTemplates:
    github:
      url: ${var.argo_github_token_template_url}
    github-app:
      url: ${var.argo_github_app_token_template_url}
      githubAppEnterpriseBaseURL: ${var.argo_github_app_token_template_enterprise_base_url}
    github:
      username: ${var.argo_github_token_username}
      password: ${var.argo_github_token_password}
  credentialTemplatesAnnotations:
    reflector.v1.k8s.emberstack.com/reflection-allowed: "true"
    reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces: external-secrets
EOF
  ]
  ### Issue inserting PEM value into values block above.
  ### var.argo_github_app_token_template_private_key needs to be formatted correctly
  dynamic "set" {
    for_each = var.argo_github_app_token_template_private_key != "" ? toset(["config"]) : toset([])
    content {
      name  = "configs.credentialTemplates.github-app.githubAppPrivateKey"
      value = var.argo_github_app_token_template_private_key
      type  = "string"
    }
  }

  dynamic "set" {
    for_each = var.argo_github_app_token_template_installation_id != "" ? toset(["config"]) : toset([])
    content {
      name  = "configs.credentialTemplates.github-app.githubAppInstallationID"
      value = var.argo_github_app_token_template_installation_id
      type  = "string"
    }
  }

    dynamic "set" {
    for_each = var.argo_github_app_token_template_app_id != "" ? toset(["config"]) : toset([])
    content {
      name  = "configs.credentialTemplates.github-app.githubAppID"
      value = var.argo_github_app_token_template_app_id
      type  = "string"
    }
  }

  dynamic "set" {
    for_each = var.argo_url != "" ? toset(["config"]) : toset([])
    content {
      name  = "global.domain"
      value = substr(var.argo_url, 0, 8) == "https://" ? substr(var.argo_url, 8, -1) : var.argo_url
      type  = "auto"
    }
  }

}


resource "helm_release" "argo_app_project" {
  name       = "argocd-base-projects"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "1.6.2"

  timeout = 300

  # TODO: Reformat to set and values
  namespace = kubernetes_namespace.argocd.id
  values = [<<EOF
projects:
%{for project in var.base_argo_projects}
  - name: "${project.name}"
    namespace: "${project.namespace}"
    description: "${project.description}"
    sourceRepos:
    - '*'
    destinations:
    - namespace: "*"
      server: https://kubernetes.default.svc
    roles:
    - name: platform-admin
      description: Full access to all resources
      policies:
      - p, proj:${project.name}:platform-admin, *, *, *, allow
      groups:
      - ${var.github_org}:${var.platformTeam}
    clusterResourceWhitelist:
    - group: '*'
      kind: '*'
%{endfor}
EOF
  ]

  depends_on = [var.pre_reqs, helm_release.argocd]
}
