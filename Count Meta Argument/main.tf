#First scenerio 

# resource "azurerm_resource_group" "rg" {
#     count = 4
#     name     = "rg-count"
#     location = "West Europe"
  
# }
#here it will create the 4 resource block but having same name (rg-count)and location argument in block
#sytnax name of block will be this foam azurerm_resource_group.rg[3]  
#==================================================================================================
#Second scenerio

# resource "azurerm_resource_group" "rg" {
#     count = 4
#     name     = count.index
#     location = "West Europe"
  
# }
#here it will create the 4 resource block but having different name and same location argument in block 
#like name of resource group is 0 , 1 ,2 and 3

#==================================================================================================
#thrid scenerio

# resource "azurerm_resource_group" "rg" {
#     count = 4
#     name     = "rg-count-${count.index}" #"rg-count-${count.index+10}" 
#     location = "West Europe"
  
# }

#${count.index} is string interpolation jahan hum count loop ka index string ke andar use karte ho.
#here it will create the 4 resource block but having given name only adding the value at the end and same location argument in block
#this will create the name of resource group like rg-count-0, rg-count-1, rg-count-2 and rg-count-3

#======================================================================================================
