#####################################################################
##
##      Created 07/05/2020 by admin. for test-cam-project
##
#####################################################################
variable "ssh_key_label" {}
variable "hostname" {}
variable "domainname" {}
variable "cores" {
  type = number
  default = 1
}
variable "memory" {
  type = number
  default = 1024
}
