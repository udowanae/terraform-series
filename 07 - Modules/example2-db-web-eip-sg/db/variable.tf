# passing ssh key as a variable for the db server. Note that the ssh key but be created in the same AWS region ias the server
variable "key_pair" {
  type        = string
  default     = "Class28key"

}
