#list the active account name
gcloud auth list

#list project ID
gcloud config list project

#Identify the  default region and zone
gcloud config get-value compute/zone
gcloud config get-value compute/region
gcloud compute project-info describe --project #<project_ID>

#Create env variable
export PROJECT_ID= #<project_ID>
export ZONE= #<zone>

echo $PROJECT_ID
echo $ZONE

##############################################################################################################
### Create Virtual machine - gcloud compute instances create
### gcloud compute instances create --help
### gcloud config --help
##############################################################################################################


gcloud compute instances create my-gcp-VM --machine-type n1-standard-2 --zone $ZONE

# Check configuration
gcloud config list
gcloud config list --all

# List components
gcloud components list

# Install component: Auto-complete mode gcloud interactive has auto prompting for commands
sudo apt-get install google-cloud-sdk

#Enable the gcloud interactive mode:
gcloud beta interactive

# How to SSH to VM from gcloud shell?
gcloud compute ssh my-gcp-VM --zone $ZONE

#Inside the Linux VM - Update packages and install NGINX
sudo su -
apt-get update
apt-get install nginx -y
#Confirm that NGINX is running
ps auwx | grep nginx


#Create new VM
gcloud compute instances create --help
gcloud compute instances create my-gcp-VM --machine-type n1-standard-2 --zone us-central1-f
# How to SSH to VM from gcloud shell?
gcloud compute ssh my-gcp-VM --zone us-central1-f
exit