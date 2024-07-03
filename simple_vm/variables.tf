# variable "subscription_id" {
#   type        = string
#   description = "ID da subscription que o ambiente sera configurado"
# }

# variable "tenant_id" {
#   type        = string
#   description = "Tenant ID que o ambiente sera configurado"
# }

variable "workload" {
  type        = string
  description = "Nome do workload que será configurado"
}

variable "location" {
  type        = string
  description = "Nome da localização do recurso (nome completo, não abreviado)"
}

variable "region" {
  type        = string
  description = "Nome da região onde o recurso será configurado (abreviado)"
}

variable "tags" {
  description = "Tags de identificação do projeto"
  type        = map(any)
  default     = {}
}

variable "vnet_address_space" {
  description = "Endereçamento da VNET"
  type        = list(string)
}

variable "snet_address_space" {
  description = "Nome e endereçamento das subnets"
  type        = list(string)
}

variable "vm" {
  description = "Nome e endereçamento das subnets"
  type        = map(string)
}