variable "location" {
  description = "The supported Azure location where the resource deployed"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group to deploy resources into"
  type        = string
}

variable "tags" {
  description = "A list of tags used for deployed services."
  type        = map(string)
}

variable "administrator_login" {
  type    = string
  default = "psqladmin"
}

variable "administrator_login_password" {
  type    = string
  default = "psqladmin"
}

variable "server_name" {
  type    = string
  default = "example-psqlserver"
}

variable "db_name" {
  type    = string
  default = "example-db"
}
