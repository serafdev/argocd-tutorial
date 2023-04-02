resource "argocd_project" "p" {
  metadata {
    name      = "p"
    namespace = "argocd"
    labels = {
      acceptance = "true"
    }
  }

  spec {
    description = "simple project"

    source_repos = ["https://github.com/serafdev/argocd-tutorial"]

    destination {
      server    = "https://kubernetes.default.svc"
      name      = "in-cluster"
      namespace = "default"
    }

    destination {
      server    = "https://kubernetes.default.svc"
      name      = "in-cluster"
      namespace = "helloworld"
    }

    cluster_resource_whitelist {
      group = "rbac.authorization.k8s.io"
      kind  = "ClusterRoleBinding"
    }
    cluster_resource_whitelist {
      group = "rbac.authorization.k8s.io"
      kind  = "ClusterRole"
    }

    namespace_resource_whitelist {
      group = "*"
      kind  = "*"
    }

    role {
      name = "r"
      policies = [
        "p, proj:p:r, applications, override, p/*, allow",
        "p, proj:p:r, applications, sync, p/*, allow",
        "p, proj:p:r, clusters, get, p/*, allow",
        "p, proj:p:r, repositories, create, p/*, allow",
        "p, proj:p:r, repositories, delete, p/*, allow",
        "p, proj:p:r, repositories, update, p/*, allow",
        "p, proj:p:r, logs, get, p/*, allow",
        "p, proj:p:r, exec, create, p/*, allow",
      ]
    }
  }
}
