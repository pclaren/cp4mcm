locals {
  private_key = "${tls_private_key.keyPairForAnsibleUser.private_key_pem}"
  public_ip   = "${ibm_compute_vm_instance.vm1.ipv4_address}"
}

# Key pair for Ansible user
resource "tls_private_key" "keyPairForAnsibleUser" {
 algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "ansible_ssh_key" {
    public_key          = "${tls_private_key.keyPairForAnsibleUser.public_key_openssh}"
    label               = "${var.hostname}_ansible_ssh_key"
}

# Public key to upload to VM
data "ibm_compute_ssh_key" "public_key" {
    label               = "${var.ssh_key_label}"
}


resource "ibm_compute_vm_instance" "vm1" {
  cores                  = "${var.cores}"
  memory                 = "${var.memory}"
  domain                 = "${var.domainname}"
  hostname               = "${var.hostname}"
  datacenter             = "fra02"
  ssh_key_ids            = ["${ibm_compute_ssh_key.ansible_ssh_key.id}", "${data.ibm_compute_ssh_key.public_key.id}"]
  os_reference_code      = "CENTOS_7_64"
  network_speed          = 10
  hourly_billing         = true
  private_network_only   = false
  disks                  = [25]
  local_disk             = true
}
