module "gke" {
  depends_on = [
    google_compute_subnetwork.subnetwork
  ]
  source      = "../../../tf-modules-gcp/terraform-gcp-gke-cluster/modules/cluster"
  name        = var.gke.name
  description = var.gke.description
  project     = var.gcp.project_id
  location    = var.gke.location
  # cluster_autoscaling      = var.gke.cluster_autoscaling
  ip_allocation_policy   = var.gke.ip_allocation_policy
  network                = google_compute_network.vpc_network.id
  subnetwork             = google_compute_subnetwork.subnetwork.id
  private_cluster_config = var.gke.private_cluster_config
  initial_node_count     = var.gke.initial_node_count

  node_pools = var.gke.node_pools

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}