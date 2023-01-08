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
# Add App of Apps
resource "kubectl_manifest" "argocd_app_of_apps" {
  depends_on      = [
    helm_release.kubernetes_argocd
  ]
  validate_schema = false
  yaml_body       = <<-YAML
    ---
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: app-of-apps
      namespace: argocd
    spec:
      destination:
        server: https://kubernetes.default.svc
      project: default
      source:
        path: app-of-apps
        repoURL: https://github.com/cloudinterplay/poc-gke-argocd-apps.git
        targetRevision: "main"
  YAML
}