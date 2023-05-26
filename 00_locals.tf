locals {
  project_id = < YOUR PROJECT ID >
  prefix     = < PROJECT PREFIX >
  region     = "asia-northeast1"
  zones      = ["asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c"]

  vpc_network = {
    vpc_name      = "customer-vpc"
    subnet_name   = "private-subnet"
    ip_cidr_range = "10.1.0.0/24"
  }

  nat = {
    cloud_router_name = "router"
    nat_name          = "nat"
  }

  gce = {
    instance_template_name = "nginx-template"
    instance_group_name    = "nginx-group"
    base_instance_name     = "test-vm"
    sa_name                = "test-sa"
    target_size            = 1
    max_replicas           = 3
    min_replicas           = 1
  }

  cloudsql = {
    instance_name     = "test-db"
    availability_type = "ZONAL" #(ZONAL or REGIONAL)
  }

  cloudarmor = {
    src_ip_ranges = < YOUR SOURCE IP >
    #src_ip_ranges = "0.0.0.0/0"
  }

  gcs = {
    bucket_name = "test-bucket-ducxdvuj"
  }

  external_lb = {
    lb_name = "test-external-lb"
  }

}
