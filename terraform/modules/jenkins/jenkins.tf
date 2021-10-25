terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.helm.sh/stable"
  chart      = "jenkins"
  namespace  = "devops"
  timeout    = 600
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
