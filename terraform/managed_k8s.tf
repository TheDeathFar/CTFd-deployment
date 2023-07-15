#K8S-cluster
resource "yandex_kubernetes_cluster" "CTFd-k8s-cluster" {
 network_id = yandex_vpc_network.k8s-network.id
 master {
   zonal {
     zone      = yandex_vpc_subnet.k8s-subnet-1.zone
     subnet_id = yandex_vpc_subnet.k8s-subnet-1.id
   }
   public_ip = true
 }
 service_account_id      = yandex_iam_service_account.k8s-cluster.id
 node_service_account_id = yandex_iam_service_account.k8s-node-group.id
   depends_on = [
     yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
     yandex_resourcemanager_folder_iam_member.load-balancer-admin,
     yandex_resourcemanager_folder_iam_member.vpc-public-admin,
     yandex_resourcemanager_folder_iam_member.images-puller,
     yandex_resourcemanager_folder_iam_member.images-pusher
   ]
}

#NodeGroup
resource "yandex_kubernetes_node_group" "k8s-node-group" {
  cluster_id = yandex_kubernetes_cluster.CTFd-k8s-cluster.id
  name       = var.node_group_name
  instance_template {
    name       = "node-{instance.short_id}"
    platform_id = "standard-v2"
    container_runtime {
     type = "containerd"
    }
    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.k8s-subnet-1.id]
    }
  }
  scale_policy {
    fixed_scale {
      size = 1
    }
  }
  depends_on   = [
    yandex_kubernetes_cluster.CTFd-k8s-cluster
  ]
}
