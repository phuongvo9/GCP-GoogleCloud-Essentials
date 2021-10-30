# Provision a Kubernetes cluster using Kubernetes Engine

# Package a simple ASP.NET Core app as a Docker container

# Deploy and manage Docker containers using kubectl

# Deploy your ASP.NET Core app to a pod

# Scale up your service and roll out an upgrade
export MY_ZONE=us-central1-a

#Start a Kubernetes cluster managed by Kubernetes Engine. Name the cluster hello-dotnet-cluster and configure it to run 2 nodes
gcloud container clusters create hello-dotnet-cluster\
     --zone $MY_ZONE\
     --num-nodes 2

kubectl version


#Create an ASP.NET Core app in Cloud Shell
#     ```
#     cat <<EOF > ~/global.json
#     { "sdk": { "version": "3.1.411" } }
#     EOF
#     ```
# dotnet --version

#disable Telemetry coming from your new app
export DOTNET_CLI_TELEMETRY_OPTOUT=1

#Create a skeleton ASP.NET Core web app using dotnet:
dotnet new razor -o HelloWorldAspNetCore

#Run the ASP.NET Core app
cd HelloWorldAspNetCore
dotnet run --urls=http://localhost:8080

# Access to web port 8080

#---------------------- Publish the ASP.NET Core app ----------------------------------------
#publish the app to get a self-contained DLL using the dotnet publish

dotnet publish -c Release
cd bin/Release/netcoreapp3.1/publish/
touch Dockerfile

    # FROM gcr.io/google-appengine/aspnetcore:3.1
    # ADD ./ /app
    # ENV ASPNETCORE_URLS=http://*:${PORT}
    # WORKDIR /app
    # ENTRYPOINT [ "dotnet", "HelloWorldAspNetCore.dll" ]

DEVSHELL_PROJECT_ID=<project_id>
echo $DEVSHELL_PROJECT_ID

#Build an image
docker build -t gcr.io/$DEVSHELL_PROJECT_ID/hello-dotnet:v1 .
docker run -d -p 8080:8080 gcr.io/$DEVSHELL_PROJECT_ID/hello-dotnet:v1

docker ps
docker stop <Container_ID>
gcloud config set project $DEVSHELL_PROJECT_ID


# push docker image to the Google Container Registry

gcloud docker -- push gcr.io/$DEVSHELL_PROJECT_ID/hello-dotnet:v1

#-------------------------------Create and deploy your pod to cluster
kubectl create deployment hello-dotnet \
--image=gcr.io/$DEVSHELL_PROJECT_ID/hello-dotnet:v1

kubectl get deployments
kubectl get pods

# Expose the hello-dotnet container to the internet
kubectl expose deployment hello-dotnet --type="LoadBalancer" --port=8080

kubectl get services
kubectl scale deployment hello-dotnet --replicas 3
kubectl get pods
kubectl get services
