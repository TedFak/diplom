# Network
resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name           = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}

resource "yandex_dns_zone" "svgsmsc" {
  zone   = "svgsmsc.com."
  public = true
}

resource "yandex_dns_recordset" "proxy" {
  zone_id = yandex_dns_zone.svgsmsc.id
  name    = "svgsmsc.com."
  type    = "A"
  ttl     = 600
  data    = ["${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "app" {
  zone_id = yandex_dns_zone.svgsmsc.id
  name    = "app.svgsmsc.com."
  type    = "A"
  ttl     = 600
  data    = ["${yandex_compute_instance.app.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "gitlab" {
  zone_id = yandex_dns_zone.svgsmsc.id
  name    = "gitlab.svgsmsc.com."
  type    = "A"
  ttl     = 600
  data    = ["${yandex_compute_instance.gitlab.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "grafana" {
  zone_id = yandex_dns_zone.svgsmsc.id
  name    = "grafana.svgsmsc.com."
  type    = "A"
  ttl     = 600
  data    = ["${yandex_compute_instance.monitoring.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "alertmanager" {
  zone_id = yandex_dns_zone.svgsmsc.id
  name    = "alertmanager.svgsmsc.com."
  type    = "A"
  ttl     = 600
  data    = ["${yandex_compute_instance.monitoring.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "prometheus" {
  zone_id = yandex_dns_zone.svgsmsc.id
  name    = "prometheus.svgsmsc.com."
  type    = "A"
  ttl     = 600
  data    = ["${yandex_compute_instance.monitoring.network_interface.0.nat_ip_address}"]
}