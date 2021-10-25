terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

resource "kubernetes_namespace" "devops" {
  metadata {

    labels = {
      mylabel = "devops-devops"
    }

    name = "devops"
  }
}

resource "kubernetes_namespace" "devops_dev" {
  metadata {

    labels = {
      mylabel = "devops-dev"
    }

    name = "dev"
  }
}

resource "kubernetes_namespace" "devops_homolog" {
  metadata {

    labels = {
      mylabel = "devops-homolog"
    }

    name = "homolog"
  }
}

resource "kubernetes_namespace" "devops_monitoring" {
  metadata {

    labels = {
      mylabel = "devops-monitoring"
    }

    name = "monitoring"
  }
}

