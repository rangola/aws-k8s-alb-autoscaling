provider "kubernetes" {
  host                   = aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.eks.token
}
data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.name
}
resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "namespace"
  }
}
resource "kubernetes_config_map" "config_map" {
  metadata {
    name      = "config_map"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
  data = {
    "config_map" = "config_map"
  }
}
