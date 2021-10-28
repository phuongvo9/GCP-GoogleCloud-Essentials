# perform the following tasks:

# Provision a Kubernetes cluster using Kubernetes Engine

# Package a simple ASP.NET Core app as a Docker container

# Deploy and manage Docker containers using kubectl

# Deploy your ASP.NET Core app to a pod

# Scale up your service and roll out an upgrade


#Start a Kubernetes cluster managed by Kubernetes Engine. Name the cluster hello-dotnet-cluster and configure it to run 2 nodes:
export MY_ZONE=us-central1-a
gcloud container clusters create hello-dotnet-cluster\
     --zone $MY_ZONE\
     --num-nodes 2
# Example Output:
# Creating cluster hello-dotnet-cluster...done.
# Created [https://container.googleapis.com/v1/projects/dotnet-atamel/zones/europe-west1-b/clusters/hello-dotnet-cluster].
# kubeconfig entry generated for hello-dotnet-cluster.
# NAME                  LOCATION          MASTER_VERSION  MASTER_IP      MACHINE_TYPE    NODE_VERSION   NUM_NODES  STATUS
# hello-dotnet-cluster  us-central1-a  1.14.10-gke.27   35.195.57.183  n1-standard-1  1.14.10-gke.27  2          RUNNING



