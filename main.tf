
resource "helm_release" "kube-prometheus-stack" {
  name = "kube-prometheus-stack"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitor"

  reset_values = true
  values = [
    "${file("blackbox-exporter-probe.yaml")}" # Blackbox Exporter Specs
  ]

  set {
    name  = "prometheus-node-exporter.hostRootFsMount"
    value = "false"
  }

  create_namespace = true

  depends_on = [
    helm_release.ingress-nginx
  ]
}

resource "helm_release" "prometheus-blackbox-exporter" {
  name = "prometheus-blackbox-exporter"

  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus-blackbox-exporter"
  namespace        = "monitor"
  create_namespace = true

  depends_on = [
    helm_release.ingress-nginx
  ]
}


resource "helm_release" "ingress-nginx" {
  name = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  namespace        = "ingress-nginx"
  create_namespace = true
}
