# Домашнее задание к занятию "7.2. Облачные провайдеры и синтаксис Terraform."
___
## Задача 1
___
3. Облако было ранее сконфигурировано при выполнении домашнего задания по уроку *5.4 - Оркестрация группой Docker контейнеров на примере Docker Compose* - [git](https://github.com/nikryl/devops-netology/blob/virt5.4/README.md)  
Для настроек провайдера отредактирован файл *.terraformrc* добавлен следующий блок:  
```
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```

4. Для использования переменной окружения, вместо того, чтобы указывать авторизационный токен в коде, выполнен `export YC_TOKEN=$(yc iam create-token)`. Для персистентного создания переменной можем добавить ее *~/.bashrc*.  
  
___
## Задача 2
___
1. Для создания собственно образа можно использовать Packer.  
2. Конфигурация terraform https://github.com/nikryl/devops-netology/tree/main/terraform. Вывод команды *terraform plan*
```
❯ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.netology will be created
  + resource "yandex_compute_instance" "netology" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzLzii3HYJvW6Nw2cJ79D4iWidzz04ynSCXZHoAG/0Zuo1Ua2rQ9ddwM2IWgOu5UOzbe660sBLMlrLTKUYrg5Fdj0XnM74fa2cqi9RU51KSvBgm+GMt/o7mocG0hCsSVwKe08OY9FhrAoeaTfeHpG0Numm2yGXac6rDUoaTLW9e/6vZc/LG+eddvUXota1LedEiUHspFfypBq99IC83wlZ+ERAFmOJ4W9Lhc7bpWqHMq4OwF/4ZTiHk2qV5r68u/xsh+Wf/s5H3tuQvvb/dy2pZirTWEUk+RjXIXM39Tw0gxmhwvHoI4dMNmtXwhCcFU/jaoOtwaejr0qkA6hc4Z/2Z10tdrxm07JUghVCaI2ckmEBzQoZ8vxmcT5+UU3BSHgpSt2qPoBophhwd1S/IaafLMC+7z078oY7pR83Ljd0+/44HN029p6mKaeIFfSa+ucO+BID+kMz2bNI2bLP5cNq12Xfb1gwQF0H9IYAbXgvFv/guA0Er95bnoYul2FTt6hloOWoWGkcN0nLaPJGjoW5xKvYwCAFXDQyiWmT6DVsy1aRVGcZbPi8vL/WwUDOkDs8d0tZUoE492Iiw4ko9xIMXeHstYv1pIp6RHa5y+z1mc+ymCNqdzOb4IOwJqPMJ8j3LoiXzCIyc9sesPfZ2eqcOuv2MAG59KOGxrTqqEIbnw== nikryl@gmail.com
            EOT
        }
      + name                      = "netology"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "f2edj0elvr9qpbbbug45"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.network will be created
  + resource "yandex_vpc_network" "network" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet will be created
  + resource "yandex_vpc_subnet" "subnet" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.101.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_netology = (known after apply)
  + internal_ip_address_netology = (known after apply)
```