# variables that can be overriden
variable "hostname" {
  default = ["home-opsm0", "home-opsm1", "home-opsw1", ]
  # add the hostnames, needs to be the same amount as `hosts` number on next block
}

variable "hosts" {
  type = number
  default = 3
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
  default = "2048"
}

variable "vcpu" {
  type    = number
  default = 2
}

variable "ips" {
  type    = list
  default = ["192.168.37.120", "192.168.37.121", "192.168.37.122",  ]
}

variable "ips_2" {
  type    = list
  default = ["192.168.122.120", "192.168.122.121", "192.168.122.122",  ]
}

variable "gateway" {
  default = "192.168.122.1"
}

variable "distros" {
  type    = list
  default = ["debian11", "debian11", "debian11",  ]
}

variable "distropool" {
  # the images must be on this location first, or your default pool
  default = "/var/lib/libvirt/images/"
}
