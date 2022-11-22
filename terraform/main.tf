terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"


  backend "s3" {
  endpoint   = "storage.yandexcloud.net"
  bucket     = "nikryl-netology-state"
  region     = "ru-central1"
  key        = "dev/iac7.3/terraform.tfstate"

  skip_region_validation      = true
  skip_credentials_validation = true
  }
}

#====================================================================================

provider "yandex" {
  zone = "ru-central1-a"
}

locals {
  compute_instance_count_map = {
    stage = 1
    prod  = 2
  }

  cumpute_instance_platform_map = {
    stage = "standard-v1" 
    prod  = "standard-v2"
  }

  instance_2_resources_map = {
    instance1 = [2,4]
    instance2 = [4,8]
  }
}

#====================================================================================

# Instanse with count
resource "yandex_compute_instance" "netology" {
  name = "netology-${count.index}"
  count = local.compute_instance_count_map[terraform.workspace]
  platform_id = local.cumpute_instance_platform_map[terraform.workspace]

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8bh0c781u19q50m4kj"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
#====================================================================================

# Instanse with for_each
resource "yandex_compute_instance" "netology-2" {
  for_each = local.instance_2_resources_map
  name = each.key

  resources {
    cores  = each.value[0]
    memory = each.value[1]
  }

  boot_disk {
    initialize_params {
      image_id = "fd8bh0c781u19q50m4kj"
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
#====================================================================================

resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.101.0/24"]
}
