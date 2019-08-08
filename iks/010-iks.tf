resource "ibm_container_cluster" "iks_cluster" {
  name                   = "${var.iks_cluster["name"]}"
  machine_type           = "${var.iks_cluster["machine_type"]}"
  datacenter             = "${var.datacenter}"
  hardware               = "shared"
  default_pool_size      = "${var.iks_cluster["default_pool_size"]}"
  public_vlan_id         = "${var.iks_cluster["public_vlan_id"]}"
  private_vlan_id        = "${var.iks_cluster["private_vlan_id"]}"
}

data "ibm_container_cluster_config" "iks_cluster_config" {
  cluster_name_id = "${ibm_container_cluster.iks_cluster.name}"
  config_dir      = "./"
  download = true
}

provider "kubernetes" {
  config_path = "${data.ibm_container_cluster_config.iks_cluster_config.config_dir}/${sha1("${data.ibm_container_cluster_config.iks_cluster_config.cluster_name_id}")}_${data.ibm_container_cluster_config.iks_cluster_config.cluster_name_id}_k8sconfig/config.yml"
}

resource "kubernetes_cluster_role_binding" "tillerrolebinding" {
  depends_on = ["data.ibm_container_cluster_config.iks_cluster_config"]
  metadata {
    name = "tiller"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "kube-system"
  }
}
