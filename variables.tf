variable "access-key" {
  type = string
}

variable "secret-key" {
  type = string
}

variable "ssh-access" {
  type = string
}

variable "ports" {

  type = list(number)

}

variable "instance-type" {
  type = string

}

variable "image-name" {
  type = string

}

variable "region" {

  type = string

}
variable "ownername" {

}
variable "cidr-block" {

}
variable "subnet-cidr" {

}