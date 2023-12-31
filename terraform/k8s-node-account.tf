resource "yandex_iam_service_account" "k8s-node-group" {
  name        = "k8s-node-group"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-node-group.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-pusher" {
  # Сервисному аккаунту назначается роль "container-registry.images.pusher".
  folder_id = var.folder_id
  role      = "container-registry.images.pusher"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-node-group.id}"
}
