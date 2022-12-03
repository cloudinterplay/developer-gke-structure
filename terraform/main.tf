provider "google" {
  project = var.gcp.project_id
  region  = var.gcp.region
}

data "google_client_config" "provider" {}

data "google_container_cluster" "cluster" {
  depends_on = [
    module.google_kubernetes_cluster
  ]
  name     = module.google_kubernetes_cluster.name
  location = var.gke.cluster.location
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.cluster.private_cluster_config[0].public_endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate,
  )
}