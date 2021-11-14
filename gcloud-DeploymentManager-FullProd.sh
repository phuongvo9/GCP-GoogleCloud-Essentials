
gcloud auth list
sudo apt-get update


# Python virtual environments are used to isolate package installation from the system.
sudo apt-get install virtualenv
virtualenv -p python3 venv
# Activate virtual env:
source venv/bin/activate

####
# Clone the Deployment Manager Sample Templates
###

mkdir ~/dmsamples
cd ~/dmsamples
git clone https://github.com/GoogleCloudPlatform/deploymentmanager-samples.git



