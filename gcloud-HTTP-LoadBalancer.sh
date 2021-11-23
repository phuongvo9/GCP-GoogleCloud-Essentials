
gcloud config list project
gcloud config set compute/zone us-central1-a
gcloud config set compute/region us-central1

######################################################
####### Create multiple web server instances
######################################################
    # To create the Nginx web server clusters, create the following:
    #     A startup script to be used by every virtual machine instance to setup Nginx server upon startup
    #     An instance template to use the startup script
    #     A target pool
    #     A managed instance group using the instance template

# Startup script - sets up the Nginx server
cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF

# Create an instance template, uses the startup script:
gcloud compute instance-templates create nginx-template \
--metadata-from-file startup-script=startup.sh



# Create a target pool. A target pool allows a single access point to all the instances in a group a

gcloud compute target-pools create nginx-pool


# Create a managed instance group using the instance template:

gcloud compute instance-groups managed create nginx-group \
    --base-instance-name nginx \
    --size 2 \
    --template nginx-template \
    --target-pool nginx-pool
# COnfigure Firewall so that we can connect to the machines
gcloud compute firewall-rules create www-firewall --allow tcp:80

######################################################
####### Create a Network Load Balancer
######################################################
    #L4 Network Load Balancer that points to the webservers
gcloud compute forwarding-rules create nginx-lb \
    --region us-central1 \
    --ports=80 --target-pool nginx-pool

# List all GCE - Compute engine forwarding rules
gcloud compute forwarding-rules list


######################################################
####### Create a HTTP(s) Load Balancer -  an L7 HTTP(S) Load Balancer
######################################################
# global load balancing for HTTP(S) requests destined for our instances


# First, create a health check. Health checks verify that the instance is responding to HTTP or HTTPS traffic
gcloud compute http-health-checks create http-basic-check


# Define an HTTP service and map a port name to the relevant port for the instance group.
    # the load balancing service can forward traffic to the named port:
gcloud compute instance-groups managed \
    set-named-ports nginx-group \
    --named-ports http:80


# Create a backend service:
gcloud compute backend-services create nginx-backend \
      --protocol HTTP --http-health-checks http-basic-check --global

# Add the instance group into the backend service:

gcloud compute backend-services add-backend nginx-backend \
    --instance-group nginx-group \
    --instance-group-zone us-central1-a \
    --global

# Create a default URL map that directs all incoming requests to all our instances:

gcloud compute url-maps create web-map \
    --default-service nginx-backend
# Create a target HTTP proxy to route requests to our URL map:
gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map

# Create a global forwarding rule to handle and route incoming requests. 
    #A forwarding rule sends traffic to a specific target HTTP or HTTPS proxy depending on the IP address, IP protocol, and port specified.
    #The global forwarding rule does not support multiple ports

gcloud compute forwarding-rules create http-content-rule \
    --global \
    --target-http-proxy http-lb-proxy \
    --ports 80

# Check forwarding rules
gcloud compute forwarding-rules list