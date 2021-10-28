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

# check our installed version of Kubernetes
kubectl version

# create a file to set the version of the dotnet runtime in cloud shell
    # ```
    # cat <<EOF > ~/global.json
    # { "sdk": { "version": "3.1.411" } }
    # EOF
    # ```

dotnet --version

#disable Telemetry coming from our new app
export DOTNET_CLI_TELEMETRY_OPTOUT=1

#Create a skeleton ASP.NET Core web app using the following dotnet command:
dotnet new razor -o HelloWorldAspNetCore

cd HelloWorldAspNetCore

# Run app with docker
dotnet run --urls=http://localhost:8080

    ### Example Output
        # Hosting environment: Production
        # Content root path: /home/atameldev/HelloWorldAspNetCore
        # Now listening on: http://[::]:8080
        # Application started. Press Ctrl+C to shut down.

###------Publish the ASP.NET Core app###

dotnet publish -c Release
cd bin/Release/netcoreapp3.1/publish

###------ Package the ASP.NET Core app as a Docker container ###------
touch Dockerfile

nano Dockerfile

        FROM gcr.io/google-appengine/aspnetcore:3.1
        ADD ./ /app
        ENV ASPNETCORE_URLS=http://*:${PORT}
        WORKDIR /app
        ENTRYPOINT [ "dotnet", "HelloWorldAspNetCore.dll" ]


DEVSHELL_PROJECT_ID=<project_id>
docker build -t gcr.io/$DEVSHELL_PROJECT_ID/hello-dotnet:v1 .

#  test the image locally which runs a Docker container as a daemon on port 8080 from new container image
docker run -d -p 8080:8080 gcr.io/$DEVSHELL_PROJECT_ID/hello-dotnet:v1
# Open the application with port 8080

# Verify that the app is running locally in a Docker container
docker ps

# Stop the running container
docker stop <Container_ID>


# gcloud sete the project in Google Cloud
gcloud config set project $DEVSHELL_PROJECT_ID

# push the image to Google Container Registry
gcloud docker -- push gcr.io/$DEVSHELL_PROJECT_ID/hello-dotnet:v1

###------ Create and deploy your pod to cluster ###------
# -- Create Deployemnt (Create POD)
kubectl create deployment hello-dotnet \
--image=gcr.io/$DEVSHELL_PROJECT_ID/hello-dotnet:v1

kubectl get deployments
kubectl get pods

# Expose the hello-dotnet container to the internet
kubectl expose deployment hello-dotnet --type="LoadBalancer" --port=8080

kubectl get services

# Go to http://<external IP address>:8080

# Scale up the number of pods running on the service
kubectl scale deployment hello-dotnet --replicas 3

kubectl get pods
kubectl get services
