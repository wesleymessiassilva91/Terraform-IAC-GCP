terraform {
  backend "gcs" {}
}

provider "google" {}

variable "project_id" {}
variable "application_name" {}
variable "region" {}
variable "subnetwork_id" {}
variable "network_self_link" {}
variable "subnetwork_self_link" {}

/*****************************************
  Activate Services
 *****************************************/

module "services" {
  source     = "../modules/services"
  project_id = var.project_id
}

/******************************************
	Network Module
 *****************************************/

 module "network" {
  source               = "../modules/network"
  project_id           = var.project_id
  network_self_link    = var.network_self_link
  subnetwork_self_link = var.subnetwork_self_link
  cluster_name         = var.application_name
  region               = var.region 
  depends_on           = [module.services]
}

/******************************************
	Kubernetes Module
 *****************************************/

module "kubernetes" {
  source            = "../modules/kubernetes"
  project_id        = var.project_id
  application_name  = var.application_name
  region            = var.region
  network_self_link = var.network_self_link
  subnetwork_id     = var.subnetwork_id
  depends_on        = [module.network]
}
