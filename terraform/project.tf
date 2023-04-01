resource "argocd_project" "myproject" {
  metadata {
    name      = "myproject"
    namespace = "argocd"
    labels = {
      acceptance = "true"
    }
    annotations = {
      "this.is.a.really.long.nested.key" = "yes, really!"
    }
  }

  spec {
    description = "simple project"

    source_namespaces = ["argocd"]
    source_repos      = ["*"]

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "demo"
    }

    cluster_resource_blacklist {
      group = "*"
      kind  = "*"
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
      name = "testrole"
      policies = [
        "p, proj:myproject:testrole, applications, override, myproject/*, allow",
        "p, proj:myproject:testrole, applications, sync, myproject/*, allow",
        "p, proj:myproject:testrole, clusters, get, myproject/*, allow",
        "p, proj:myproject:testrole, repositories, create, myproject/*, allow",
        "p, proj:myproject:testrole, repositories, delete, myproject/*, allow",
        "p, proj:myproject:testrole, repositories, update, myproject/*, allow",
        "p, proj:myproject:testrole, logs, get, myproject/*, allow",
        "p, proj:myproject:testrole, exec, create, myproject/*, allow",
      ]
    }
  }
}
