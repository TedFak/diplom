resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    proxy:
      ansible_host: ${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}
      ansible_user: ubuntu
    db1:
      ansible_host: ${yandex_compute_instance.db1.network_interface.0.nat_ip_address}
      ansible_user: ubuntu
    db2:
      ansible_host: ${yandex_compute_instance.db2.network_interface.0.nat_ip_address}
      ansible_user: ubuntu
    app:
      ansible_host: ${yandex_compute_instance.app.network_interface.0.nat_ip_address}
      ansible_user: centos
    gitlab:
      ansible_host: ${yandex_compute_instance.gitlab.network_interface.0.nat_ip_address}
      ansible_user: centos
    runner:
      ansible_host: ${yandex_compute_instance.runner.network_interface.0.nat_ip_address}
      ansible_user: centos
    monitoring:
      ansible_host: ${yandex_compute_instance.monitoring.network_interface.0.nat_ip_address}
      ansible_user: centos
  vars:
    ansible_connection: ssh
    become_user: root
    become_method: sudo
    deprecation_warnings: False
    command_warnings: False
    ansible_port: 22
    domain_name: svgsmsc.com
    DOC
  filename = "../ansible/inventory.yml"

  depends_on = [
    yandex_compute_instance.proxy,
    yandex_compute_instance.app,
    yandex_compute_instance.db1,
    yandex_compute_instance.db2,
    yandex_compute_instance.gitlab,
    yandex_compute_instance.runner,
    yandex_compute_instance.monitoring,
    yandex_dns_recordset.proxy,
    yandex_dns_recordset.app,
    yandex_dns_recordset.alertmanager,
    yandex_dns_recordset.prometheus,
    yandex_dns_recordset.prometheus,
    yandex_dns_recordset.gitlab,
    yandex_dns_recordset.grafana,
    yandex_dns_zone.svgsmsc,
    yandex_vpc_network.default,
    yandex_dns_zone.svgsmsc,
    yandex_vpc_subnet.default,
  ]
}
