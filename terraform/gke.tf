module "gke" {
  depends_on = [
    google_compute_subnetwork.subnetwork
  ]
  source  = "../../../tf-modules-gcp/terraform-gcp-gke-cluster/modules/cluster"
  cluster = merge(
    {
      project    = var.gcp.project_id,
      network    = google_compute_network.vpc_network.id,
      subnetwork = google_compute_subnetwork.subnetwork.id
    },
    var.gke.cluster
  )
  node_pools = var.gke.node_pools
}