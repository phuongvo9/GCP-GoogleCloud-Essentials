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
# view the resource usage across the pods
kubectl top pods


# Enable bash autocompletion for kubectl
source <(kubectl completion bash)
    #kubectl <tab> <tab>


# Deploy Pods to GKE clusters
kubectl create deployment --image nginx nginx-1

kubectl get pods

export my_pod_name=nginx-1-6664c49886-8p9kv
echo $my_pod_name
kubectl describe $my_pod_name


# Push a file into a container

nano ~/test.html
<html> <header><title>This is title</title></header>
<body> Hello world </body>
</html>

#  place the file into the appropriate location within the nginx container in the nginx Pod to be served statically

kubectl cp ~/test.html $my_nginx_pod:/usr/share/nginx/html/test.html


# Expose the Pod for testing
kubectl expose pod $my_nginx_pod --port 80 --type LoadBalancer

curl http://[EXTERNAL_IP]/test.html

kubectl top pods

# Introspect GKE Pods
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Create a soft link as a shortcut to the working directory.
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s

cd ~/ak8s/GKE_Shell/

kubectl apply -f ./new-nginx-pod.yaml

# Use shell redirection to connect to a Pod

kubectl exec -it new-nginx /bin/bash
#  If the Pod had several containers, you could specify one by name with the -c option
apt-get update
apt-get install nano
cd /usr/share/nginx/html
nano test.html


# set up port forwarding from Cloud Shell to the nginx Pod (from port 10081 of the Cloud Shell VM to port 80 of the nginx container):
kubectl port-forward new-nginx 10081:80


curl http://127.0.0.1:10081/test.html

