variable "project_id" {
  type        = string
  description = "The project to run tests against"
}

variable "region" {
  description = "The Google Cloud region to deploy Guacamole into"
  default     = "us-central1"
}

variable "zone" {
  description = "For zonal Guacamole resources, deploy into this zone"
  default     = "us-central1-c"
}

variable "cluster_name" {
  description = "GKE Cluster to host Guacamole"
  default     = "guacamole-gke"
}

variable "custom_role_id" {
  description = "Project-level custom role ID for IAP JWT verification"
  type        = string
  default     = "iap_jwt_verifier"
}

variable "name_suffix" {
  description = "Suffix appended to resource names to allow multiple deployments in the same project."
  type        = string
  default     = ""
}
