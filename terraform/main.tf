# Provider
provider "yandex" {
  zone = "ru-central1-a"
}

# Instanse
resource "yandex_compute_instance" "netology" {
  name = "netology"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "f2edj0elvr9qpbbbug45"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

# Network
resource "yandex_vpc_network" "network" {
  name = "network"
}

# Subnet
resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.101.0/24"]
}


# Output
output "internal_ip_address_netology" {
  value = yandex_compute_instance.netology.network_interface.0.ip_address
}

output "external_ip_address_netology" {
  value = yandex_compute_instance.netology.network_interface.0.nat_ip_address
}
