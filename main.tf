terraform {
  backend "azurerm" {
    key                  = "snackingnextgen-dev-comp-eastus2.tfstate"
    resource_group_name  = "ODDA-TFSTATE-DEV-RG"
    storage_account_name = "oddatfstateeus2devsa"
    container_name       = "resource-tfstate"
  }
}


//IF IT IS FOR LOCAL USE ONLY WHAT IS PURPOSE OF THE BLOCK?
//The step - name: terraform init put all the modules in the same context by copying /.github/templates/aks/ to this working dir

locals {
  solution_name       = demo400
  region              = demo400
  environment         = demo400
  vnet_name           = demo400
  vnet_rg             = demo400
  resource_group_name = demo400
}


module "kubernetes" {
  // Clonning module over HTTPS.
  source                        = "git@github.com/Mars-DNA/DNA-Central-Deployment.git//_modules/kubernetes-cluster?ref=main"
  tags                          = module.solution_settings.tags
  solution_settings             = module.solution_settings.settings
  providers = {
    azurerm.remote = azurerm.remote
  }
  depends_on = [
    azurerm_resource_group.kubernetes
  ]
}
