#Network
resource "yandex_vpc_network" "k8s-network" { 
    name = var.network_name
    description = "New network for k8s" 
}

resource "yandex_vpc_subnet" "k8s-subnet-1" {
 name           = var.subnetwork_name
 zone           = var.zone
 network_id     = "${yandex_vpc_network.k8s-network.id}"
 v4_cidr_blocks = ["10.2.0.0/16"]
 depends_on = [
    yandex_vpc_network.k8s-network,
  ]
}