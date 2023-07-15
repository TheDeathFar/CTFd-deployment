output "cluster_name" {
  value   = yandex_kubernetes_cluster.CTFd-k8s-cluster.name
}

output "cluster_id" {
  value   = yandex_kubernetes_cluster.CTFd-k8s-cluster.id
}

output "cluster_ipv4_range" {
  value   = yandex_kubernetes_cluster.CTFd-k8s-cluster.cluster_ipv4_range
}

output "service_ipv4_range" {
  value   = yandex_kubernetes_cluster.CTFd-k8s-cluster.service_ipv4_range
}

output "internal_v4_address" {
  value   = yandex_kubernetes_cluster.CTFd-k8s-cluster.master.*.internal_v4_address[0]
}

output "external_v4_address" {
  value   = yandex_kubernetes_cluster.CTFd-k8s-cluster.master.*.external_v4_address[0]
}

output "internal_ip_address_remote_vm" {
  value = yandex_compute_instance.remote.network_interface.0.ip_address
}
 
output "external_ip_address_remote_vm" {
  value = yandex_compute_instance.remote.network_interface.0.nat_ip_address
}