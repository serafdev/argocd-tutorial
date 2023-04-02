resource "argocd_application" "helloworld" {
  depends_on = [
    argocd_project.p
  ]

  metadata {
    name      = "helloworld"
    namespace = "argocd"
  }

  spec {
    project = "p"

    source {
      repo_url        = "https://github.com/serafdev/argocd-tutorial"
      path            = "deploy"
      target_revision = "master"
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "helloworld"
    }

    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }

      sync_options = ["CreateNamespace=true"]

      retry {
        limit = "5"
        backoff {
          duration     = "30s"
          max_duration = "2m"
          factor       = "2"
        }
      }
    }
  }
}
