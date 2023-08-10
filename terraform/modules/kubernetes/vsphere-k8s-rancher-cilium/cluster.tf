resource "rancher2_cloud_credential" "vsphere" {
  name = "vsphere-credential"
  vsphere_credential_config {
    username     = var.vsphere_user
    password     = var.vsphere_password
    vcenter      = var.vsphere_vcenter_address
    vcenter_port = var.vsphere_vcenter_port
  }
}

resource "rancher2_machine_config_v2" "controlplane_config" {
  generate_name = "controlplane-node"
  vsphere_config {
    cfgparam      = ["disk.enableUUID=TRUE"]
    cpu_count     = var.cluster_controlplane_cpu
    creation_type = "vm"
    clone_from    = var.cluster_image_name
    datacenter    = var.cluster_vmware_datacenter
    datastore     = var.cluster_vmware_datastore
    pool          = var.cluster_vmware_resource_pool
    memory_size   = var.cluster_controlplane_memory
    network       = ["${var.cluster_controlplane_network_name}"]
  }
}

resource "rancher2_machine_config_v2" "etcd_config" {
  generate_name = "etcd-node"
  vsphere_config {
    cfgparam      = ["disk.enableUUID=TRUE"]
    cpu_count     = var.cluster_etcd_cpu
    creation_type = "vm"
    clone_from    = var.cluster_image_name
    datacenter    = var.cluster_vmware_datacenter
    datastore     = var.cluster_vmware_datastore
    pool          = var.cluster_vmware_resource_pool
    memory_size   = var.cluster_etcd_memory
    network       = ["${var.cluster_etcd_network_name}"]
  }
}

resource "rancher2_machine_config_v2" "worker_config" {
  generate_name = "worker-node"
  vsphere_config {
    cfgparam      = ["disk.enableUUID=TRUE"]
    cpu_count     = var.cluster_worker_cpu
    creation_type = "vm"
    clone_from    = var.cluster_image_name
    datacenter    = var.cluster_vmware_datacenter
    datastore     = var.cluster_vmware_datastore
    pool          = var.cluster_vmware_resource_pool
    memory_size   = var.cluster_worker_memory
    network       = ["${var.cluster_worker_network_name}"]
  }
}

resource "rancher2_cluster_v2" "tfcluster" {
  name                  = var.cluster_name
  kubernetes_version    = var.cluster_kubernetes_version
  enable_network_policy = false
  rke_config {
    machine_pools {
      name                         = "controlplane-pool"
      cloud_credential_secret_name = rancher2_cloud_credential.vsphere.id
      control_plane_role           = true
      etcd_role                    = false
      worker_role                  = false
      quantity                     = var.cluster_controlplane_count
      machine_config {
        name = rancher2_machine_config_v2.controlplane_config.name
        kind = rancher2_machine_config_v2.controlplane_config.kind
      }
    }
    machine_pools {
      name                         = "etcd-pool"
      cloud_credential_secret_name = rancher2_cloud_credential.vsphere.id
      control_plane_role           = false
      etcd_role                    = true
      worker_role                  = false
      quantity                     = var.cluster_etcd_count
      machine_config {
        name = rancher2_machine_config_v2.etcd_config.name
        kind = rancher2_machine_config_v2.etcd_config.kind
      }
    }
    machine_pools {
      name                         = "worker-pool"
      cloud_credential_secret_name = rancher2_cloud_credential.vsphere.id
      control_plane_role           = false
      etcd_role                    = false
      worker_role                  = true
      quantity                     = var.cluster_worker_count
      machine_config {
        name = rancher2_machine_config_v2.worker_config.name
        kind = rancher2_machine_config_v2.worker_config.kind
      }
    }
    machine_selector_config {
      config = {
        cloud-provider-name = "vsphere"   
        }
      }

    machine_global_config = <<EOF
cluster-cidr: 10.111.0.0/16
cluster-dns: 10.112.0.10
cluster-domain: cluster.lan
cni: cilium
disable-kube-proxy: true
etcd-expose-metrics: false
service-cidr: 10.112.0.0/16
service-node-port-range: 30000-31000
EOF

    upgrade_strategy {
      control_plane_concurrency = "25%"
      worker_concurrency        = "25%"
    }

    etcd {
      snapshot_schedule_cron = "0 */5 * * *"
      snapshot_retention     = 5
    }

    chart_values = <<EOF
rancher-vsphere-cpi:
  vCenter:
    datacenters: ${var.cluster_vmware_datacenter}
    host: ${var.vsphere_vcenter_address}
    password: ${var.vsphere_password}
    username: ${var.vsphere_user}
rancher-vsphere-csi:
  asyncQueryVolume:
    enabled: true
  csiAuthCheck:
    enabled: true
  improvedCsiIdempotency:
    enabled: true
  improvedVolumeTopology:
    enabled: true
  onlineVolumeExtend:
    enabled: true
  storageClass:
    allowVolumeExpansion: true
  triggerCsiFullsync:
    enabled: true
  vCenter:
    datacenters: ${var.cluster_vmware_datacenter}
    host: ${var.vsphere_vcenter_address}
    password: ${var.vsphere_password}
    username: ${var.vsphere_user}
rke2-cilium:
  bgpControlPlane:
    enabled: true
  cilium:
    ipv6:
      enabled: false
  hubble:
    enabled: true
    metrics:
      serviceMonitor:
        enabled: true
        interval: 30s
    relay:
      enabled: true
      prometheus:
        serviceMonitor:
          enabled: true
          interval: 30s
    ui:
      enabled: true
  image:
    tag: v1.13.4
  ingressController:
    enabled: true
  k8sServiceHost: 127.0.0.1
  k8sServicePort: '6443'
  kubeProxyReplacement: strict
  operator:
    image:
      tag: v1.13.4
  preflight:
    image:
      tag: v1.13.4
EOF
  }
}
