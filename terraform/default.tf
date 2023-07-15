provider "yandex" {
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  service_account_key_file = var.service_account_key_file
  zone = var.zone
}

#ContainerRegistry

resource "yandex_container_registry" "ctfd-reg" {
  name = "ctfd-reg"
  folder_id = var.folder_id
  labels = {
    my-label = "ctfd-reg-test"
  }
}