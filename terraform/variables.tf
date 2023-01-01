# Path to Helm values files
variable "environment_dir" {
  type = string
}
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
# Configuration of the Helm chart for ArgoCD
variable "argocd" {
  type = object({
    namespace : string
    chart : object({
      repository : string,
      version : string
      values_files : list(string)
    })
  })
}