environment           = "production"
kubernetes_version    = "v1.27.12+rke2r1"
kubernetes_image_name = "Ubuntu-2404-cloudimg"

#nodes
cluster_worker_count = 3
cluster_worker_cpu = 6
cluster_worker_memory = 16384
cluster_worker_disk = 40

cluster_etcd_cpu          = 4
cluster_etcd_memory       = 4096
cluster_etcd_disk         = 30
cluster_etcd_count        = 3

cluster_controlplane_cpu          = 4
cluster_controlplane_memory       = 8192
cluster_controlplane_disk         = 30
cluster_controlplane_count        = 3