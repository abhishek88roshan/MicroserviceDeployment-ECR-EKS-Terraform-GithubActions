output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = module.eks.cluster_endpoint
}

output "ecr_repository_url" {
  description = "URL of the existing ECR repository"
  value       = data.aws_ecr_repository.httpd_app.repository_url
}

output "kms_key_arn" {
  description = "ARN of the existing KMS key used for EKS cluster encryption"
  value       = data.aws_kms_alias.cluster.target_key_arn
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the existing CloudWatch log group for EKS control plane"
  value       = data.aws_cloudwatch_log_group.eks.arn
}
