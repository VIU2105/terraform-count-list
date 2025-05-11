#1st scenario with variable "rg_name" set to "rg1"
# resource "azurerm_resource_group" "rg1" {
#     count = 0
#     name = var.rg_name
#     location = "West Europe"
# }
#No changes. Your infrastructure matches the configuration.

#=========================================================================================

#2nd scenario with variable "rg_name" set to "rg1"
# resource "azurerm_resource_group" "rg1" {
#     count = 1
#     name = var.rg_name
#     location = "West Europe"
# }

#Plan: 1 to add, 0 to change, 0 to destroy.

# Now currently we are having the single entry which is string but we we want list/array value to be used in 
#count loop.

#=================================================================================================

#3rd scenario with variable list define against argument

# resource "azurerm_resource_group" "rg1" {
#     name = var.rg_list
#     location = "West Europe"
# } 

# Here we will receive this error :var.rg_list is a list of string
#which mean that argument must be a single value not the list of values.

#===============================================================================================

#4th scenario with variable list define the list value with error

# resource "azurerm_resource_group" "rg1" {
#     name = var.rg_list[] #[9] ,[]
#     location = "West Europe"
# } 

# Error: Invalid index
# │
# │   on main.tf line 33, in resource "azurerm_resource_group" "rg1":
# │   33:     name = var.rg_list[9]
# │     ├────────────────
# │     │ var.rg_list is list of string with 5 elements
# │
# │ The given key does not identify an element in this collection value.///

#===============================================================================================

#5th scenario with variable list define the single list value

# resource "azurerm_resource_group" "rg1" {
#     name = var.rg_list[0] 
#     location = "West Europe"
# } 

#===============================================================================================

#6th scenario now to reslove upper scenario we can use the count loop with list single value.
resource "azurerm_resource_group" "rg1" {
    count =6
    name = var.rg_list[2]-count.index #error
    # name = "${var.rg_list[0]}-${count.index}" 
    # name = var.rg_list[0]"-${count.index}" #this generate the error
    location = "West Europe"
} 
#name     = "rg11-5" and azurerm_resource_group.rg1[5]

#================================================================================================
#7th scenario now to reslove upper scenario we can use the count loop with list multiple value.

# resource "azurerm_resource_group" "rg1" {
#     count= 5
#     # count = length(var.rg_list) #length it's a function
#     name = "${var.rg_list[count.index]}-${count.index}" 
#     location = "West Europe"
# }

#if we put the count = 6 then it will through the error as we have only 5 element in the list. 
#we calling the count.index in var.rg_list[count.index]

#===============================================================================================
#8th scenario now to reslove upper scenario we can use the count loop with list multiple value from tfvars file.

# resource "azurerm_resource_group" "rg1" {
# #   count = 5
#   count = length(var.rg_list) #length it's a function
#   name = var.rg_list[count.index] #this will work as well
#   location = "West Europe"
# }

#it will work on defined pattern in tfvars file which mean it's completely depend upon the sequence how input has been passed in it
#In this case we are remove the one entry from tfvars now it will create the 4 resource group.
#Plan: 2 to add, 0 to change, 3 to destroy
#if we see the output then we will see the 4 resource group will be created with the name rg11,rg12,rg14,rg15
#one rg13 is removed from the list. so below all resources will name of resource block get change due to which 
#terraform will destroy the resource and create the new one. like rg13 is having azurerm_resource_group.rg1[2]
# Now r13 is removed so rg14 will get this name azurerm_resource_group.rg1[2] so perviuos block is removed and create new one

#===============================================================================================
#to overcome this problem for_each meta argument is used.
#9th scenario now to reslove upper scenario we can use the for_each loop with list multiple value from tfvars file.

# resource "azurerm_resource_group" "name" {
     
#     # count = length((var.list)) #length it's a function
#     # name = var.list[count.index] #this will work as well
#     for_each =toset(var.rg_list)
#     name = each.key
#     location = "West Europe"#to set is used to convert the list into set
  
# }

#===========================================

resource "azurerm_resource_group" "rg_count" {
    # count = length(var.rg_name)
    count =5
    name = "rg-viu1"
    # name = "rg_name-count.index"
    # name = var.rg_name[count.index]
    # name = "rg-${count.index}"
    # name= "${var.rg_name[count.index]}"
    # name= "${var.rg_name}"[count.index]
    #name = var.rg_name #  var.rg_name is a list of string
    location = "Japan East"
  
}