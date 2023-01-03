resource "kubernetes_namespace" "argocd" {
  depends_on = [
    module.gke
  ]
  metadata {
    annotations = {
      name = var.argocd.namespace
    }

    name = var.argocd.namespace
  }
}
resource "helm_release" "kubernetes_argocd" {
  depends_on = [
    kubernetes_namespace.argocd
  ]
  name       = "argocd"
  repository = var.argocd.chart.repository
  chart      = "argo-cd"
  version    = var.argocd.chart.version
  namespace  = kubernetes_namespace.argocd.id
  timeout    = 600

  values = [for s in var.argocd.chart.values_files : file("${local.environment_dir}/${s}")]
}