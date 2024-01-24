terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

module "service-bus-module" {
  source = "git::https://github.com/mleisa/assignment.git"
  namespace_name = "namespace-bb"
  queue_name_and_dlq = {
    "queue3" = true,
    "queue4" = false
  }
  action_group_name = "team2"
  alert_rule = {
    rule-c-queue3 = {
      alert_name         = "Service-C-Queue3-DLQ"
      metric_name        = "DeadletteredMessages"
      threshold          = 0
      dimension_operator = "Include"
      queue_name_list    = ["queue3"]
    },
    rule-c-queue4 = {
      alert_name         = "Service-C-Queue4"
      metric_name        = "Messages"
      threshold          = 10
      dimension_operator = "Include"
      queue_name_list    = ["queue4"]
    }
  }
}
