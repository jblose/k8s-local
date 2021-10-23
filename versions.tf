terraform {
  required_version = "~> 1.0"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
