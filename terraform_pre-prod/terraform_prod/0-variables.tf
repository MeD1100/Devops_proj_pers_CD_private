# variable "profile" {
#   type = string
#   description = "Profile name of the AWS user"
# }

variable "cluster_name" {
  type = string
  description = "Cluster name"
}

variable "cluster_version" {
  type = string
  description = "Cluster version"
}

variable "region" {
  type = string
  description = "region name"
}