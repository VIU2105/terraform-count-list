variable "rg_name"{
    # type = string
    # default = "rg1"
}

variable "rg_list" {
  type    = list(string)
  default = ["rg1", "rg2", "rg3", "rg4", "rg5"]
}