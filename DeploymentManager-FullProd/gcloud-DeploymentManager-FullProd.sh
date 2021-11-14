
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





#################################################################
####### Create a Monitoring workspace
#################################################################

# Configure an uptime check and alert policy in Cloud Monitoring
# Configure an alerting policy and notification
# Configure a Dashboard with a Couple of Useful Charts

# Create a test VM with ApacheBench

sudo apt-get update
sudo apt-get -y install apache2-utils

ab -n 1000 -c 100 http://<Your_IP>:8080/

ab -n 5000 -c 100 http://<Your_IP>:8080/

ab -n 10000 -c 100 http://<Your_IP>:8080/

ab -n 10000 -c 100 http://<Your_IP>:8080/
ab -n 10000 -c 100 http://<Your_IP>:8080/

# user01@instance-1:~$ ab -n 1000 -c 100 http://35.231.224.194:8080/
# This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
# Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
# Licensed to The Apache Software Foundation, http://www.apache.org/

# Benchmarking 35.231.224.194 (be patient)
# Completed 100 requests
# Completed 200 requests
# Completed 300 requests
# Completed 400 requests
# Completed 500 requests
# Completed 600 requests
# Completed 700 requests
# Completed 800 requests
# Completed 900 requests
# apr_socket_recv: Connection timed out (110)
# Total of 934 requests completed