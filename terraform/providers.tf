terraform {
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "5.0.1"
    }
  }
}

provider "argocd" {
  server_addr = "localhost:8081"
}
