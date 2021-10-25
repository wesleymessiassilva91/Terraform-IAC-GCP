variable "region" {}

resource "google_sql_database_instance" "master" {
  name             = "master"
  database_version = "POSTGRES_13"
  region           = var.region
  deletion_protection = false

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size         = 10
  }
}