#Kubernetes Engine: Qwik Start
#list the active account name
gcloud auth list
#list project ID
gcloud config list project
#Identify the  default region and zone and project
gcloud config get-value compute/zone
gcloud config get-value compute/region
gcloud compute project-info describe --project #<project_ID>

#Create environment variable
export PROJECT_ID= #<project_ID>
export ZONE= #<zone>

echo $PROJECT_ID
echo $ZONE
################################################################################
##############      Kubernetes Engine: Qwik Start ##############################
################################################################################

gcloud container clusters create my-cluster

#After creating the cluster, we need authentication credentials to interact with it.
# How can we authenticate the cluster?
gcloud container clusters get-credentials
gcloud container clusters get-credentials my-cluster --zone us-central1-a --project qwiklabs-gcp-04-8e82c3add7fa
    #Fetching cluster endpoint and auth data.
    #kubeconfig entry generated for my-cluster.
# new Deployment hello-server from the hello-app container image
kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0

# Expose deployment
kubectl expose deployment hello-server --type=Loadbalancer --port=8080
kubectl get service
#kubectl get service -f
# http://[EXTERNAL-IP]:8080

# Delete the cluster in Google Kubernetes Engine vid gcloud cmd
gcloud container clusters delete my-cluster 

