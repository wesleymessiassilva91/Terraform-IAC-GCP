variable "project_id" {}
variable "application_name" {}
variable "region" {}
variable "network_self_link" {}
variable "subnetwork_id" {}

resource "google_container_cluster" "gke-cluster" {
  project                     = var.project_id
  provider                    = google-beta
  name                        = var.application_name
  remove_default_node_pool    = true
  enable_binary_authorization = false
  enable_intranode_visibility = false
  enable_kubernetes_alpha     = false
  location                    = var.region
  initial_node_count          = 1
  network                     = var.network_self_link
  subnetwork                  = var.subnetwork_id

  networking_mode = "VPC_NATIVE"

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "10.10.8.0/28"
  }

  ip_allocation_policy {}

  cluster_telemetry {
    type = "ENABLED"
  }

  addons_config  {
    istio_config {
      disabled = true
    }
  }

  node_config {
    labels = {  
      ambiente = "dev"
      projeto  = "appagro"
    }
    tags = ["projeto", "appagro", "ambiente", "dev"]
  }
}

resource "google_container_node_pool" "gke-cluster-ndpool" {
  project  = var.project_id
  name     = "gke-cluster-ndpool"
  cluster  = google_container_cluster.gke-cluster.name
  location = var.region
  initial_node_count = 1

  autoscaling {
    max_node_count = 1
    min_node_count = 0
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  upgrade_settings {
    max_surge       = "1"
    max_unavailable = "0"
  }

  node_config {
    disk_size_gb = 50
    disk_type    = "pd-standard"
    machine_type = "n1-standard-1"

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/pubsub",
      "https://www.googleapis.com/auth/datastore"
    ]

    labels = {  
      ambiente = "dev"
      projeto  = "appagro"
    }
    tags = ["projeto", "appagro", "ambiente", "dev"]
  }

}

resource "google_compute_global_address" "ingress-ip-gke" {
  name         = "gke-public-address-${var.application_name}-${terraform.workspace}"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
  project      = var.project_id
}
