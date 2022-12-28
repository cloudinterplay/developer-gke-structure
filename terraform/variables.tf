# Google Cloud Platform
variable "gcp" {
  description = "The GCP common parameters"
  type = object({
    project_id = string
    region     = string
  })
}
# VPC
variable "vpc" {
  description = "The GCP VPC parameters"
  type = object({
    network    = string
    subnetwork = string
  })
}
# GKE
variable "gke" {
  type        = any
  description = "The GKE configuration"
}
