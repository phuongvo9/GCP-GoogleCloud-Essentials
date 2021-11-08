# Cloud Shell provides the following features and capabilities:

# Temporary Compute Engine VM
# Command-line access to the instance through a browser
# 5 GB of persistent disk storage ($HOME dir)
# Preinstalled Cloud SDK and other tools
# gcloud: for working with Compute Engine, Google Kubernetes Engine (GKE) and many Google Cloud services
# gsutil: for working with Cloud Storage
# kubectl: for working with GKE and Kubernetes
# bq: for working with BigQuery
# Language support for Java, Go, Python, Node.js, PHP, and Ruby
# Web preview functionality
# Built-in authorization for access to resources and instances


export MY_BUCKET_NAME_1= qwiklabs-gcp-00-df121be69c5a
export MY_BUCKET_NAME_2=$MY_BUCKET_NAME_1-2
export MY_REGION=us-central1


# Create Cloud storage bucket with the gsutil command, which is supplied by the Cloud SDK
gsutil mb gs://$MY_BUCKET_NAME_2



# CREATE INSTANCE
gcloud compute instances list

gcloud compute zones list | grep $MY_REGION
export MY_ZONE = us-central1-c
# gcloud command line to create a virtual machine
export MY_VMNAME=second-vm
gcloud compute instances create $MY_VMNAME \
--machine-type "e2-standard-2" \
--image-project "debian-cloud" \
--image-family "debian-9" \
--subnet "default"
--zone $MY_ZONE



## Use the gcloud command line to create a service account
gcloud iam service-accounts create test-service-account2 --display-name "test-service-account2"

#################### Work with Cloud Storage in Cloud Shell

# Download a file to Cloud Shell and copy it to Cloud Storage
gsutil cp gs://cloud-training/ak8s/cat.jpg cat.jpg
gsutil cp cat.jpg gs://$MY_BUCKET_NAME_1

gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg gs://$MY_BUCKET_NAME_2/cat.jpg

# Set the access control list for a Cloud Storage object
gsutil acl get gs://$MY_BUCKET_NAME_1/cat.jpg  > acl.txt
cat acl.txt

[
  {
    "entity": "project-owners-560255523887",
    "projectTeam": {
      "projectNumber": "560255523887",
      "team": "owners"
    },
    "role": "OWNER"
  },
  {
    "entity": "project-editors-560255523887",
    "projectTeam": {
      "projectNumber": "560255523887",
      "team": "editors"
    },
    "role": "OWNER"
  },
  {
    "entity": "project-viewers-560255523887",
    "projectTeam": {
      "projectNumber": "560255523887",
      "team": "viewers"
    },
    "role": "READER"
  },
  {
    "email": "google12345678_student@qwiklabs.net",
    "entity": "user-google12345678_student@qwiklabs.net",
    "role": "OWNER"
  }
]

# change the object to have private access
gsutil acl set private gs://$MY_BUCKET_NAME_1/cat.jpg

gsutil acl get gs://$MY_BUCKET_NAME_1/cat.jpg  > acl-2.txt
cat acl-2.txt
#######################################################
###### Authenticate as a service account in Cloud Shell
gcloud config list


