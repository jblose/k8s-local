
resource "kubernetes_namespace" "kube-prom-stack" {
  metadata {
    name = "monitor"
  }
}

resource "helm_release" "kube-prometheus-stack" {
  name = "kube-prometheus-stack"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.kube-prom-stack.id

  reset_values = true
  values = [
    "${file("blackbox-exporter-probe.yaml")}" # Blackbox Exporter Specs
  ]

  set {
    name  = "prometheus-node-exporter.hostRootFsMount"
    value = "false"
  }

  depends_on = [
    kubernetes_namespace.kube-prom-stack
  ]

}

resource "helm_release" "prometheus-blackbox-exporter" {
  name = "prometheus-blackbox-exporter"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-blackbox-exporter"
  namespace  = kubernetes_namespace.kube-prom-stack.id

  depends_on = [
    kubernetes_namespace.kube-prom-stack
  ]

}
