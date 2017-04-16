# Gen Certs
resource "null_resource" "ssl_gen" {

  provisioner "local-exec" {
    command = <<EOF
${ path.module }/init-cfssl \
${ var.data_dir }/.cfssl \
${ var.aws_region } \
${ var.internal_tld } \
${ var.k8s_service_ip }
EOF
  }
}

resource "null_resource" "dummy_dependency" {
  depends_on = [ "null_resource.ssl_gen" ]
}

