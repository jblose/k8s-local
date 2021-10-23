
resource "kubernetes_namespace" "kube-prom-stack" {
  metadata {
    name = "monitor"
  }
}

resource "helm_release" "kube-prom-stack" {
  name = "kube-prometheus-stack"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.kube-prom-stack.id

  set {
    name  = "prometheus-node-exporter.hostRootFsMount"
    value = "false"
  }

  depends_on = [
    kubernetes_namespace.kube-prom-stack
  ]

}
