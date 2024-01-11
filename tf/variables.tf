variable "GOOGLE_PROJECT" {
  type        = string
  default     = ""
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = ""
  description = "GCP region to use"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 2
  description = "GKE nodes number"
}