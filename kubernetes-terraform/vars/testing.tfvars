environment           = "testing"
kubernetes_version    = "v1.28.8+rke2r1"
kubernetes_image_name = "Ubuntu-2404-cloudimg"

#nodes
cluster_worker_count  = 1
cluster_worker_cpu    = 2
cluster_worker_memory = 4096
cluster_worker_disk   = 40

cluster_etcd_cpu    = 2
cluster_etcd_memory = 4096
cluster_etcd_disk   = 30
cluster_etcd_count  = 1

cluster_controlplane_cpu    = 2
cluster_controlplane_memory = 4096
cluster_controlplane_disk   = 30
cluster_controlplane_count  = 1