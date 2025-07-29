output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = module.eks.cluster_endpoint
}

# REMOVE or COMMENT THIS BLOCK (not supported in v19.21.0)
# output "kubeconfig" {
#   description = "Kubeconfig file content for this EKS cluster"
#   value       = module.eks.kubeconfig
#   sensitive   = true
# }

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.httpd_app.repository_url
}

