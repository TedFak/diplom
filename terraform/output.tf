output "internal_ip_address_proxy" {
  value = "${yandex_compute_instance.proxy.network_interface.0.ip_address}"
}

output "external_ip_address_proxy" {
  value = "${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_db1" {
  value = "${yandex_compute_instance.db1.network_interface.0.ip_address}"
}

output "external_ip_address_db1" {
  value = "${yandex_compute_instance.db1.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_db2" {
  value = "${yandex_compute_instance.db2.network_interface.0.ip_address}"
}

output "external_ip_address_db2" {
  value = "${yandex_compute_instance.db2.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_app" {
  value = "${yandex_compute_instance.app.network_interface.0.ip_address}"
}

output "external_ip_address_app" {
  value = "${yandex_compute_instance.app.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_gitlab" {
  value = "${yandex_compute_instance.gitlab.network_interface.0.ip_address}"
}

output "external_ip_address_gitlab" {
  value = "${yandex_compute_instance.gitlab.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_runner" {
  value = "${yandex_compute_instance.runner.network_interface.0.ip_address}"
}

output "external_ip_address_runner" {
  value = "${yandex_compute_instance.runner.network_interface.0.nat_ip_address}"
}
output "internal_ip_address_monitoring" {
  value = "${yandex_compute_instance.monitoring.network_interface.0.ip_address}"
}

output "external_ip_address_monitoring" {
  value = "${yandex_compute_instance.monitoring.network_interface.0.nat_ip_address}"
}