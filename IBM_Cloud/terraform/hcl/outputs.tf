output "public_ip" {
  description = "The public IP address of the instance."
  value       = "${local.public_ip}"
}

output "private_key" {
  description  = "The private key of the instance."
  sensitive    = true
  value        = "${local.private_key}"
}
