variable "ingress" {
    type = list(number)
    default = [80,443,8080]
}

variable "egress" {
    type = list(number)
    default = [80,443]
}
