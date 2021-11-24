# Use kubectl to build and manipulate GKE clusters

# Use kubectl and configuration files to deploy Pods

# Use Container Registry to store and deploy containers

export my_zone=us-central1-a
export my_cluster=standard-cluster-1
# create a Kubernetes cluster.
gcloud container clusters create $my_cluster --num-nodes 3 --zone $my_zone --enable-ip-alias


### Modify GKE Clusters
# resize
gcloud container clusters resize $my_cluster --zone $my_zone --num-nodes=4

#Connect to a GKE Cluster
    # This command creates a .kube directory in the home directory
gcloud container clusters get-credetials $my_cluster --zone $my_zone

cat ~/.kube/config 

# Use kubectl to inspect a GKE cluster
    #The sensitive certificate data is replaced with DATA+OMITTED.
kubectl config view
kubectl cluster-info
# Kubernetes control plane is running at https://34.72.163.216
# GLBCDefaultBackend is running at https://34.72.163.216/api/v1/namespaces/kube-system/services/default-http-backend:http/proxy
# KubeDNS is running at https://34.72.163.216/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
# Metrics-server is running at https://34.72.163.216/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

# Print active context
kubectl config current-context
# print out some details for all the cluster contexts in the kubeconfig file
kubectl config get-contexts

# change the active context

# use this approach to switching the active context when your kubeconfig file has the credentials and configuration for several clusters already populated
kubectl config use-context gke_${GOOGLE_CLOUD_PROJECT}_us-central1-a_standard-cluster-1

# view the resource usage across the nodes of the cluster
kubectl top nodes