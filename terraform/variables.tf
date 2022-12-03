# Google Cloud Platform
variable "gcp" {
  description = "The GCP common parameters"
  type = object({
    project_id = string
    region     = string
  })
}
# GKE
variable "gke" {
  type        = any
  description = "The GKE configuration"
}
