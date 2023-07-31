variable "git_repo" {
    description = "Git Repo that Terraform setup the resource from."
    default = "taco_daoc_core"
    type = string
}
variable "INBOUND_CIDR" {
    description = "CIDR Blocks that will be able to access the rds database."
    type = string
}