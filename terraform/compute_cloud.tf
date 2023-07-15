#CreateNewVM
resource "yandex_compute_instance" "remote" {
  name        = var.remote_name
  zone        = var.zone
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.k8s-subnet-1.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(".ssh/id_rsa.pub")}"
  }
}