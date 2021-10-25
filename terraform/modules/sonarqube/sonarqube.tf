resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://charts.helm.sh/stable"
  chart      = "sonarqube"
  namespace  = "qa"
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}