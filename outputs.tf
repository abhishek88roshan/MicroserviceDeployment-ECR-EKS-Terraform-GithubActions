output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = module.eks.cluster_endpoint
}

output "kubeconfig" {
  description = "Kubeconfig content for this EKS cluster"
  value       = module.eks.kubeconfig
  sensitive   = true
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.httpd_app.repository_url
}
