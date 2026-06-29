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
  default     = "us-central1-a"
}

variable "network_name" {
  description = "VPC to use for Guacamole resources"
  default     = "guacamole-vpc"
  type        = string
}

variable "db_name" {
  description = "CloudSQL Instance Name"
  default     = "guacamole-mysql"
}

variable "db_username" {
  description = "Guacamole Database User"
  default     = "guac-db-user"
}

variable "external_url" {
  description = "URL used to access Guacamole - defaults to sslip.io, a wildcard DNS service. Change this if you have wish to use your own domain and will create the A record manually."
  default     = "sslip.io"
}

variable "db_management_vm" {
  description = "Google Compute Engine VM used to manage the Guacamole Database."
  default     = "db-mgmt-vm"
}

variable "nwr_master_node" {
  description = "GKE Private Cluster Master Node Network Range"
  default     = "172.16.0.32/28"
}

variable "required_apis" {
  description = "Google Cloud APIs required by this tutorial."
  default = ["cloudresourcemanager.googleapis.com", 
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    #"containerregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "servicenetworking.googleapis.com",
    "iap.googleapis.com",
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
  "stackdriver.googleapis.com"]
}
variable "name_suffix" {
  description = "Suffix to append to resource names, enabling multiple deployments in the same project."
  type        = string
  default     = ""
}

variable "host_subnet_cidr" {
  description = "CIDR for the Guacamole host (GKE node) subnet. Override per deployment to avoid overlap when two deployments must both peer with the same compute VPC."
  type        = string
  default     = "10.10.0.0/24"
}

variable "pods_ipv4_cidr_block" {
  description = "Pin the GKE pod range (cluster_ipv4_cidr_block). Empty = let GKE auto-allocate. Pin it when a peered network's firewall must allow a stable pod source range."
  type        = string
  default     = ""
}

variable "create_custom_role" {
  description = "Whether to create the IAP JWT verifier custom role. Set false when the role already exists (e.g. a second deployment in the same project)."
  type        = bool
  default     = true
}

variable "enable_public_ip" {
  type        = bool
  default     = false
  description = "Enable public IP on Cloud SQL (required when accessed from outside the VPC, e.g. from a second App Engine deployment that cannot use a second VPC connector)."
}
