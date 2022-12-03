module "google_kubernetes_cluster" {
  # Production
  source                                    = "git::https://github.com/tf-modules-gcp/terraform-gcp-gke-cluster.git/?ref=main"
  # Local developing
  # source                                    = "../../../tf-modules-gcp/terraform-gcp-gke-cluster"
  cluster_name                              = var.gke.cluster.name
  cluster_location                          = var.gke.cluster.location
  cluster_initial_node_count                = var.gke.cluster.initial_node_count
  cluster_ip_allocation_policy              = var.gke.cluster.ip_allocation_policy
  cluster_network                           = google_compute_network.vpc_network.name
  cluster_subnetwork                        = google_compute_subnetwork.subnetwork.name
  cluster_master_authorized_networks_config = var.gke.cluster.master_authorized_networks_config
  cluster_private_cluster_config            = var.gke.cluster.private_cluster_config
  cluster_node_config                       = var.gke.cluster.node_config
  cluster_remove_default_node_pool          = var.gke.cluster.remove_default_node_pool
}