provider "rancher2" {
  api_url    = var.rancher2_api_url
  access_key = var.rancher2_access_key
  secret_key = var.rancher2_secret_key
}

resource "rancher2_cluster" "gke-cluster" {

  name                      = var.cluster_name
  description               = var.cluster_description
  enable_cluster_monitoring = false

  gke_config {

    cluster_ipv4_cidr                       = ""
    credential                              = file("${path.module}/${var.credential_file}")
    disk_size_gb                            = var.gke_disk_size
    disk_type                               = var.gke_disk_type
    enable_alpha_feature                    = false
    enable_auto_repair                      = false
    enable_auto_upgrade                     = false
    enable_horizontal_pod_autoscaling       = true
    enable_http_load_balancing              = true
    enable_kubernetes_dashboard             = false
    enable_legacy_abac                      = false
    enable_master_authorized_network        = false
    enable_network_policy_config            = true
    enable_nodepool_autoscaling             = true
    enable_private_endpoint                 = false
    enable_private_nodes                    = false
    enable_stackdriver_logging              = true
    enable_stackdriver_monitoring           = true
    image_type                              = var.image_type
    ip_policy_cluster_ipv4_cidr_block       = ""
    ip_policy_cluster_secondary_range_name  = ""
    ip_policy_create_subnetwork             = true
    ip_policy_node_ipv4_cidr_block          = ""
    ip_policy_services_ipv4_cidr_block      = ""
    ip_policy_services_secondary_range_name = ""
    ip_policy_subnetwork_name               = ""
    issue_client_certificate                = true
    kubernetes_dashboard                    = false
    labels                                  = {}
    local_ssd_count                         = 0
    locations                               = []
    machine_type                            = var.gke_machine_type
    maintenance_window                      = ""
    master_ipv4_cidr_block                  = ""
    master_version                          = var.gke_kubernetes_version
    max_node_count                          = var.max_node_count
    min_node_count                          = var.min_node_count
    network                                 = "default"
    node_count                              = var.desired_node_count
    node_pool                               = ""
    node_version                            = ""
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]
    preemptible     = false
    project_id      = var.gke_project_id
    resource_labels = {}
    service_account = ""
    sub_network     = ""
    taints          = []
    use_ip_aliases  = true
    zone            = "${var.gke_region}-a"
  }
}

# the kubeconfig for this cluster
resource "local_file" "kubeconfig" {
  filename          = "kubeconfig-${var.cluster_name}.yaml"
  file_permission   = "0600"
  sensitive_content = rancher2_cluster.gke-cluster.kube_config
}

output "hint" {
  value = "Workload cluster is ready: use kubectl --kubeconfig kubeconfig-${var.cluster_name}.yaml <cmd> for more!"
}

