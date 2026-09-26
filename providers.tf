terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.6.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
  }
  required_version = ">= 1.16.0"
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

data "azurerm_kubernetes_cluster" "my_cluster" {
  name                = var.cluster_name
  resource_group_name = var.rg_name
}

provider "kubernetes" {
  host                   = local.kube_host
  client_certificate     = local.kube_client_certificate
  client_key             = local.kube_client_key
  cluster_ca_certificate = local.kube_cluster_ca_certificate
}

provider "kubectl" {
  host                   = local.kube_host
  client_certificate     = local.kube_client_certificate
  client_key             = local.kube_client_key
  cluster_ca_certificate = local.kube_cluster_ca_certificate
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = local.kube_host
    client_certificate     = local.kube_client_certificate
    client_key             = local.kube_client_key
    cluster_ca_certificate = local.kube_cluster_ca_certificate
  }
}