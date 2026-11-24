# Debian 13
resource "proxmox_download_file" "tmpl_debian_13" {
  content_type       = "vztmpl"
  datastore_id       = "pve"
  node_name          = "vidro"
  url                = "http://download.proxmox.com/images/system/debian-13-standard_13.6-1_amd64.tar.zst"
  checksum           = "4c0c27ca6ceab5ef0b84db57825a00f26157ef1854bafe97297813e1cbe8ecb8cc9c453cab6b3b0efe1ba193a50c47ece1e41d950e411b8730b835b71e9e754b"
  checksum_algorithm = "sha512"
}
