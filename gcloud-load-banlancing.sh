###############################################################################################
###############      1. Set up a network load balancer.                         ###############
###############      2. Set up an HTTP load balancer.                           ###############
###############      3. Hands-on network load balancers and HTTP load balancers.###############
################################################################################################
#list active account
gcloud auth list
gcloud config list project

# Get Region and Zone
gcloud config get-value compute/zone
# Set Zone
gcloud config set compute/zone us-central1-a
# Set Region
gcloud config set compute/region us-central1



### Create multiple web server instances
# Create Instances- install Apache - configure homepage
gcloud compute instances create www1 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --zone us-central1-a \
    --tags network-lb-tag \
    --metadata startup-script ="#! /bin/bash
        sudo apt-get update
        sudo apt-get install apache2 -y
        sudo service apache2 restart
        echo '<!doctype html><html><body><h1>www1</h1></body></html>' | tee /var/www/html/index.html"

gcloud compute instances create www2 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --zone us-central1-a \
    --tags network-lb-tag \
    --metadata startup-script = "#! /bin/bash
        sudo apt-get update
        sudo apt-get install apache2 -y
        sudo service apache2 restart
        echo '<!doctype html><html><body><h1>www2</h1></body></html>' | tee /var/www/html/index.html"
gcloud compute instances create www3 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --zone us-central1-a \
    --tags network-lb-tag \
    --metadata startup-script ="#! /bin/bash
        sudo apt-get update
        sudo apt-get install apache2 -y
        sudo service apache2 restart
        echo '<!doctype html><html><body><h1>www3</h1></body></html>' | tee /var/www/html/index.html"


#Create a firewall rule to allow external traffic to the VM instances - gcloud compute firewall-rules
gloud compute firewall-rules create www-firewall-network-lb \
    --target-tags network-lb-tag --allow tcp:80
#Get External_IP of instances
gcloud compute instances list

#Verify each apache/VM instances is running with curl
curl http:// #[External_IP]

# CONFIGURE THE LOAD BALANCING SERVICE - Network Load balancer
# Create a static External IP (Public IP) for our load balancer
gcloud compute addresses create network-lb-ip-1 \
    --region us-central1

# Add a legacy HTTP health check resource
gcloud compute http-health-checks create basic-check

# Add a target pool (backend) in same region
gcloud compute target-pools create www-pool \
    --region us-central1
    --http-health-check basic-check

#Add the instances to the pool
gcloud compute target-pools add-instances www-pool \
    --instances www1,ww2,www3

#Add a forwarding rule
gcloud compute forwarding-rules create www-rule \
    --region us-central1
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool


# SEND TRAFFIC TO THE INSTANCES VIA NETWORK LOAD BALANCER
# Check the External IP address of the Network Load balancer
gcloud compute forwarding-rules describe www-rule --region us-central1

while true; do curl -m1 External_IP; done