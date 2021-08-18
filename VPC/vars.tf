
variable "AWS_REGION" {
  default = "ap-southeast-1"
}

variable "aws_availability_zones" {
    description = "Availability zones"
    type        = list(string)
    default     = [
        "ap-southeast-1a",
        "ap-southeast-1b"
    ]
}

variable "public_subnets" {
    description = "Public Subnet"
    type = list(string)
    default = ["10.10.1.0/24","10.10.2.0/24"]
}

variable "private_subnets" {
    description = "Private Subnet"
    type = list(string)
    default = ["10.10.10.0/24","10.10.20.0/24"]
}

variable "public_names" {
  description = "Public names"
  type        = list(string)
  default     = ["subnet-public-a","subnet-pubic-b"]
}

variable "private_names" {
  description = "Private names"
  type        = list(string)
  default     = ["subnet-private-a","subnet-private-b"]
}

variable "BUCKET_NAME" {
  default = "clusters.gandi.my.id"
}