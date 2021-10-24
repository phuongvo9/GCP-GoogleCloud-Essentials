#list the active account name
gcloud auth list
#list project ID
gcloud config list project
#Identify the  default region and zone
gcloud config get-value compute/zone
gcloud config get-value compute/region
gcloud compute project-info describe --project #<project_ID>

#Create environment variable
export PROJECT_ID= #<project_ID>
export ZONE= #<zone>

echo $PROJECT_ID
echo $ZONE

##############################################################################################################
### Create Virtual machine - gcloud compute instances create
### gcloud compute instances create --help
### gcloud config --help
##############################################################################################################

# Create Windows Virtual Machine?
gcloud compute images list

#####################################################
#gcloud compute instances create VM_NAME \
#   [--image=IMAGE | --image-family=IMAGE_FAMILY] \
#   --image-project=IMAGE_PROJECT
#   --machine-type=MACHINE_TYPE
#gcloud compute images describe IMAGE_NAME \
#    --project=IMAGE_PROJECT
#####################################################

# How to check the server instance is ready for an RDP connection?
gcloud compute instances get-serial-port-output instance-1

#------------------------------------------------------------
#Instance setup finished. instance-1 is ready to use.
#------------------------------------------------------------

# How to set a password for logging into the RDP in Cloud Shell?
gcloud compute reset-windows-password instance-1 --zone us-central1-a --user admin














