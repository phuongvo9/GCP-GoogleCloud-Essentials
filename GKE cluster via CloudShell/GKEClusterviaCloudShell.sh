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
