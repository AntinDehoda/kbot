module "gke_cluster" {
  source         = "github.com/AntinDehoda/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = 1
}
terraform {
  backend "gcs" {
    bucket = "bucket_degoda_32"
    prefix = "terraform/state"
  }
}