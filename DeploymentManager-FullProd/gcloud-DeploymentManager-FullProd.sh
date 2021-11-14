
gcloud auth list
sudo apt-get update


# Python virtual environments are used to isolate package installation from the system.
sudo apt-get install virtualenv
virtualenv -p python3 venv
# Activate virtual env:
source venv/bin/activate

#################################################################
####### Clone the Deployment Manager Sample Templates
#################################################################
mkdir ~/dmsamples
cd ~/dmsamples
git clone https://github.com/GoogleCloudPlatform/deploymentmanager-samples.git

#################################################################
####### Explore the Sample Files
#################################################################
cd ~/dmsamples/deploymentmanager-samples/examples/v2

cd nodejs/python

gcloud compute zones list

nano nodejs.yaml
nano nodejs.py
#################################################################
####### RUN THE APPLICATION AFTER MODIFYING THE PARAMETERS
#################################################################
gcloud deployment-manager deployments create advanced-configuration --config nodejs.yaml
gcloud compute forwarding-rules list



#################################################################
####### Create a Monitoring workspace
#################################################################






