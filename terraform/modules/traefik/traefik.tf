resource "helm_release" "traefik" {
  namespace  = var.namespace_devops
  repository = var.repository
  chart      = var.chart
  version    = "10.0.2"
  name       = var.name

  values = [
    file("values.yaml")
  ]
}