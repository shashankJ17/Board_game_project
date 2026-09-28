variable "ami" {
    description = "Attaching AMI ID via AMI-Catalog"
    default = "ami-01a00762f46d584a1"
}

variable "instance_type" {
    description = "Attaching instance type"
    default = "c7i-flex.large"
}