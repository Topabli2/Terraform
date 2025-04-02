# Firewall Rule: SSH
resource "google_compute_firewall" "fw_ssh" {
  name          = "fw_rule_ssh_22"
  network       = google_compute_network.myvpc.id
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-tag"]
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
}

# Firewall Rule: HTTP Port 80
resource "google_compute_firewall" "fw_http" {
  name          = "fw_rule_http_80"
  network       = google_compute_network.myvpc.id
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["webserver-tag"]
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
}
