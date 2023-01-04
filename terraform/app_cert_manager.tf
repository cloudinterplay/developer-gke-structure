module "cert_manager" {
  depends_on = [
    module.gke
  ]
  source  = "git::https://github.com/tf-modules-gcp/terraform-gcp-gke-cert-manager.git//modules/cert-manager?ref=0.1.0"
  # Local Development
  # source  = "../../../tf-modules-gcp/terraform-gcp-gke-cert-manager/modules/cert-manager"
  environment_dir = var.environment_dir
  sa_sufix        = var.gke.cluster.name
  project_id      = var.gcp.project_id
  helm_config     = var.cert_manager
  clusterIssuers  = var.clusterIssuers
}