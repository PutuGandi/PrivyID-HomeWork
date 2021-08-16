
variable "AWS_REGION" {
  default = "ap-southeast-1"
}

variable "aws_availability_zones" {
    description = "Availability zones"
    type        = string
    default     = "ap-southeast-1a"
}

variable "public_subnets" {
    description = "Public Subnet"
    type = string
    default = "10.10.1.0/24"
}

variable "private_subnets" {
    description = "Private Subnet"
    type = string
    default = "10.10.10.0/24"
}

