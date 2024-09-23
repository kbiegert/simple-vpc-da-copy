#
#
terraform {
    required_version = ">= 1.0.0"
    required_providers {
        ibm = {
            source  = "IBM-Cloud/ibm"
            version = ">=1.45.1"
        }
    }
}

provider "ibm" {
    ibmcloud_api_key = var.ibmcloud_api_key
    region           = var.region
}

variable "ibmcloud_api_key" {
    type        = string
    description = "an IBM Cloud api key from an account that can create a VPC"
    sensitive   = true
}
variable "region" {
    type        = string
    default     = "us-south"
    description = "the name of the region where the vpc will be created"
}

variable "prefix" {
    type         = string
    description = "a string prefix to add to created resources"
}

variable "resource_group_id" {
    type        = string
    description = "the ID of the resource group where the VPC is to be created"
}

resource "ibm_is_vpc" "vpc" {
    name = "${var.prefix}-vpc"
    resource_group = var.resource_group_id
}

resource "ibm_is_subnet" "subnet" {
    name = "${var.prefix}-${var.region}-1"
    vpc  = ibm_is_vpc.vpc.id
    zone = "${var.region}-1"
    ipv4_cidr_block = "10.240.0.0/18"
}