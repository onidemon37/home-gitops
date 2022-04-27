# instance the provider
provider "libvirt" {
  uri = "qemu:///system"
}

terraform {
  required_version = ">= 1.1.7"
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}
