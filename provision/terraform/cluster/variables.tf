# variables that can be overriden
variable "hostname" {
  default = ["home-opsm0", "home-opsm1", "home-opsm2", "home-opsw1", "home-opsw2",]
  # add the hostnames, needs to be the same amount as `hosts` number on next block
}

variable "hosts" {
  type = number
  default = 5
  # number of hosts
}

variable "domain" {
  default = "ninhu.xyz"
}

variable "interface" {
  type = string
  default = "ens3"
}

variable "interface_2" {
  type = string
  default = "ens4"
}

variable "memory" {
  type = string
  default = "1024"
}

variable "vcpu" {
  type    = number
  default = 1
}
variable "ips" {
  type    = list
  default = ["192.168.37.120", "192.168.37.121", "192.168.37.122", "192.168.37.123", "192.168.37.124",]
}

variable "ips_2" {
  type    = list
  default = ["192.168.122.120", "192.168.122.121", "192.168.122.122", "192.168.122.123", "192.168.122.124",]
}

variable "gateway" {
  default = "192.168.37.53"
}

variable "distros" {
  type    = list
  default = ["debian11", "debian11", "debian11", "debian11", "debian11",]
}

variable "distropool" {
  # the images must be on this location first, or your default pool
  default = "/var/lib/libvirt/images/"
}
