terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "distro-qcow2" {
  count  = var.hosts
  name   = "${var.hostname[count.index]}.qcow2"
  pool   = "default"
  # default pool for your vms
  source = "${var.distropool}${var.distros[count.index]}.qcow2"
  format = "qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  count = var.hosts
  name = "commoninit-${var.hostname[count.index]}.iso"
  pool = "default"
  user_data = templatefile("${path.module}/templates/cloud_init.cfg", {
    host_name = var.hostname[count.index]
    auth_key  = file("${path.module}/ssh/id_rsa.pub")
  })

  network_config = templatefile("${path.module}/templates/network_config_multiple.cfg", {
    domain    = var.domain
    interface = var.interface
    ip_addr   = var.ips[count.index]
    interface_2 = var.interface_2
    ip_addr_2   = var.ips_2[count.index]

    gateway   = var.gateway
  })
}

resource "libvirt_domain" "domain-distro" {
  count = var.hosts
  name = "${var.hostname[count.index]}"
  memory = var.memory
  vcpu = var.vcpu
  cloudinit = element(libvirt_cloudinit_disk.commoninit.*.id, count.index)

  network_interface {
    network_name = "br0"
    addresses    = [var.ips[count.index]]
  }

  # Uncomment this if using network_config_multiple.cfg a second network
  network_interface {
    network_name = "default"
    addresses    = [var.ips_2[count.index]]
  }

  # IMPORTANT
  # Ubuntu can hang is a isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = "true"
  }

  disk {
    volume_id = element(libvirt_volume.distro-qcow2.*.id, count.index)
  }
}
