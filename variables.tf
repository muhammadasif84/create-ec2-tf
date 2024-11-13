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

variable "image-id" {
  type = string

}

variable "region" {

  type = string

}