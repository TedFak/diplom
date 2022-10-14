resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 120"
  }

  depends_on = [local_file.inventory]
}
resource "null_resource" "proxy" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.yml ../ansible/proxy.yml -vvv"
  }

  depends_on = [null_resource.wait]
}

resource "null_resource" "db" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.yml ../ansible/mysql.yml"
  }

  depends_on = [null_resource.proxy]
}

resource "null_resource" "wordpress" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.yml ../ansible/wordpress.yml"
  }

  depends_on = [null_resource.db]
}

resource "null_resource" "gitlab" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.yml ../ansible/gitlab.yml"
  }

  depends_on = [null_resource.wordpress]
}

resource "null_resource" "node_exporter" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.yml ../ansible/node_exporter.yml"
  }

  depends_on = [null_resource.gitlab]
}

resource "null_resource" "monitoring" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.yml ../ansible/monitoring.yml"
  }

  depends_on = [null_resource.node_exporter]
}

resource "null_resource" "runner" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.yml ../ansible/runner.yml"
  }

  depends_on = [null_resource.monitoring]
}