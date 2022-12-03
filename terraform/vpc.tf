resource "google_compute_network" "vpc_network" {
  name = var.gke.cluster.network
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "subnetwork" {
  depends_on = [
    google_compute_network.vpc_network
  ]
  name          = var.gke.cluster.subnetwork
  ip_cidr_range = "10.0.0.0/24"
  region        = var.gcp.region
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
}