resource "helm_release" "prometheus-operator" {
  chart      = "stable/prometheus-operator"
  name       = "prometheus"
  namespace  = "monitoring"
  timeout    = "1800"

  # depends_on = [
  #   "kubernetes_namespace.monitoring"
  # ]
  values = [
    file("prometheus-operator-values.yaml")
  ]
}