# Quick environment deployment 
This code is used to deploy quick standardized environments for testing purposes. 

## Resources 
### This code deploys the following resources: 
* Virtual Network
* Subnet
* Virtual Machines w/ IIS configured 
### Required existing resources: 
* Virtual Network Hub
  * Hub Resource Group
  * Hub Virtual Network
* Azure Key Vault
## Root module file structure

The main module directory contains the following files:

| Filename         | Content                                                                                                                                                                                                                                                                                                                                                                      |
|------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| main.tf          | Contains the module requirements, for providers, data sources if needed.                                                                                                                                                                                                                                                                                                    |
| variables.tf     | Contains the input variables for the whole module.                                                                                                                                                                                                                                                                                                                           |
| output.tf        | Contains the output variables for the whole module.  | 
| local.tags.tf        | Contains the tag variables for the whole module. 
## Sub modules file structure

For each sub module directory, you should have the following files:

| Filename     | Content                                                                                                |
|--------------|--------------------------------------------------------------------------------------------------------|
| main.tf      | Contains the resource code, version requirements, for providers, data sources if needed.                              |
| variables.tf | Contains the input variables for the whole module.                                                     |
| output.tf    | Contains the output variables for the whole module.                                                    |


## Variables 
Below is a breakdown of the variables required to deploy this Terraform template: 
| Variable Name     | Description                                                                                               |
|--------------|--------------------------------------------------------------------------------------------------------|
| subscription_id      | subscription to deploy the resources in                                |
| location | Azure region                                                  |
| environment   | Deployment environment (dev,test,prod,etc)                                                |
| kv | Azure Key Vault Resource ID |
| secrets | Name of Key Vault Secret to obtain | 
| address_space | Virtual Network address space | 
| subnets | Subnet address space | 
| vm_sku | Select the VM size/sku | 
| capacity | The amount of virtual machines to deploy - count starts at 0 for naming | 
| source_ip | Your public IP address for the NSG regarding RDP | 


