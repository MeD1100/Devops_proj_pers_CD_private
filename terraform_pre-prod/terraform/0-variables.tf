# variable "access_key_PFE_pre-prod" {
#   type = string
#   description = "Access Key ID of the user account"
# }
# variable "secret_key_PFE_pre-prod" {
#   type = string
#   description = "Secret Key to access to the user account"
# }

# variable "access_key_PFE_prod" {
#   type = string
#   description = "Access Key ID of the user account"
# }
# variable "secret_key_PFE_prod" {
#   type = string
#   description = "Secret Key to access to the user account"
# }

# variable "access_key" {

# }
# variable "secret_key" {

# }

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