output "reverse_proxy_public_ip" {
  value = "${aws_instance.reverse_proxy.public_ip}"
}

output "reverse_proxy_elastic_ip" {
  value = "${aws_eip.reverse_proxy_eip.public_ip}"
}
