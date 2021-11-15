## Cloud Monitoring to monitor GKE cluster infrastructure, Istio, and applications deployed on GKE

### IMPLEMENT
    # Create a GKE cluster

    # Deploy a microservices application to it

    # Define latency and error SLIs and SLOs for it

    # Configure Cloud Monitoring to monitor your SLIs

    # Deploy a breaking change to the application and use Cloud Monitoring to troubleshoot and resolve the issues that result

    # Validate that your resolution addresses the SLO violation

### Target: Learn

    # How to deploy a microservices application on an existing GKE cluster

    # How to select appropriate SLIs/SLOs for an application

    # How to implement SLIs using Cloud Monitoring features

    # How to use Cloud Trace, Profiler, and Debugger to identify software issues



gcloud auth list

gcloud config set compute/zone us-west1-b
export PROJECT_ID=$(gcloud info --format='value(config.project)')
gcloud container clusters list

# Create a Monitoring workspace

# Get GKE credential
gcloud container clusters get-credentials shop-cluster --zone us-west1-b
kubectl get nodes

### Deploy application
git clone https://github.com/GoogleCloudPlatform/training-data-analyst

# Create soft link to the working dir
ln -s ~/training-data-analyst/blogs/microservices-demo-1 ~/microservices-demo-1

# Download and install skaffold:

curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && chmod +x skaffold && sudo mv skaffold /usr/local/bin