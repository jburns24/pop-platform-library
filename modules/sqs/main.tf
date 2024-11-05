module "sqs" {
  source     = "terraform-aws-modules/sqs/aws"
  version    = "4.2.0"
  name       = var.sqs_fifo_name
  fifo_queue = true
}