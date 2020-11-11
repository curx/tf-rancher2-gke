# rancher2 terraform plugin with Google Kubernetes Engine

A workload kubernetes cluster on Google Kubernetes Engine (GKE) provided with
terraform rancher2 provider 

See terraform rancher2 provider [documentation](https://registry.terraform.io/providers/rancher/rancher2/latest/docs)

## Preparations

* Terraform must be installed (https://learn.hashicorp.com/tutorials/terraform/install-cli)
* A Service Account credetial file must be created on GKE (https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/hosted-kubernetes-clusters/gke/)

## Usage

* ``terraform init``
* ``terraform plan``
* ``terraform apply``
