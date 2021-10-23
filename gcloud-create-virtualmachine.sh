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

#######################################################
# Create Virtual machine
# gcloud compute instances create --help
# gcloud config --help
#######################################################


gcloud compute instances create gcelab2 --machine-type n1-standard-2 --zone $ZONE

# Check configuration
gcloud config list
gcloud config list --all

# List components
gcloud components list

# Install component: Auto-complete mode gcloud interactive has auto prompting for commands
sudo apt-get install google-cloud-sdk

#Enable the gcloud interactive mode:
gcloud beta interactive


ps auwx | grep nginx
