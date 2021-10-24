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
  --metadata startup-script="#! /bin/bash
    sudo apt-get update
    sudo apt-get install apache2 -y
    sudo service apache2 restart
    echo '<!doctype html><html><body><h1>www1</h1></body></html>' | tee /var/www/html/index.html"

gcloud compute instances create www2 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --zone us-central1-a \
    --tags network-lb-tag \
    --metadata startup-script="#! /bin/bash
    sudo apt-get update
    sudo apt-get install apache2 -y
    sudo service apache2 restart
    echo '<!doctype html><html><body><h1>www2</h1></body></html>' | tee /var/www/html/index.html"

# --metadata strartup-script="" <= no space
gcloud compute instances create www3 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --zone us-central1-a \
    --tags network-lb-tag \
    --metadata startup-script="#! /bin/bash
        sudo apt-get update
        sudo apt-get install apache2 -y
        sudo service apache2 restart
        echo '<!doctype html><html><body><h1>www3</h1></body></html>' | tee /var/www/html/index.html"


#Create a firewall rule to allow external traffic to the VM instances - gcloud compute firewall-rules
gcloud compute firewall-rules create www-firewall-network-lb \
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
    --region us-central1 \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool


# SEND TRAFFIC TO THE INSTANCES VIA NETWORK LOAD BALANCER
# Check the External IP address of the Network Load balancer
gcloud compute forwarding-rules describe www-rule --region us-central1

#Test traffic to Network load balancer - Replace External_IP_Load_Balancer to real IP
while true; do curl -m1 External_IP_Load_Balancer; done

### CREATE AN HTTP LOAD BALANCER
# Create the load balancer template 
    #HTTP(S) Load Balancing is implemented on Google Front End (GFE)
gcloud compute instance-templates create lb-backend-template \
   --region=us-central1 \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --image-family=debian-9 \
   --image-project=debian-cloud \
   --metadata=startup-script='#! /bin/bash
     apt-get update
     apt-get install apache2 -y
     a2ensite default-ssl
     a2enmod ssl
     vm_hostname="$(curl -H "Metadata-Flavor:Google" \
     http://169.254.169.254/computeMetadata/v1/instance/name)"
     echo "Page served from: $vm_hostname" | \
     tee /var/www/html/index.html
     systemctl restart apache2'
#Create a managed instanc group based on the template
gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=us-central1-a

#Create the fw-allow-health-check firewall rule. This is an ingress rule that allows traffic from the Google Cloud health checking systems (130.211.0.0/22 and 35.191.0.0/16
gcloud compute firewall-rules create fw-allow-health-check \
    --network=default \
    --action=allow \
    --direction=ingress \
    --source-ranges=130.211.0.0/22,35.191.0.0/16 \
    --target-tags=allow-health-check \
    --rules=tcp:80
# Now that the instances are up and running, set up a global static external IP address that our customers use to reach our load balancer.
gcloud compute addresses create lb-ipv4-1 \
    --ip-version=IPV4 \
    --global
#Check the External IP
gcloud compute addresses describe lb-ipv4-1 \
    --format="get(address)" \
    --global

#Create healthcheck for the load balancer
gcloud compute health-checks create http http-basic-check \
    --port 80

#Create a backend service 
gcloud compute backend-services create web-backend-service \
    --protocol=HTTP \
    --port-name=http \
    --health-checks=http-basic-check \
    --global
#Add our instance group as the backend to the backend service:

gcloud compute backend-services add-backend web-backend-service \
    --instance-group=lb-backend-group \
    --instance-group-zone=us-central1-a \
    --global
#Create a URL map to route the incoming requests to the default backend service:
gcloud compute url-maps create web-map-http \
    --default-service web-backend-service
#Create a target HTTP proxy to route requests to your URL map:
gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map-http
#Create a global forwarding rule to route incoming requests to the proxy:
gcloud compute forwarding-rules create http-content-rule \
    --address=lb-ipv4-1\
    --global \
    --target-http-proxy=http-lb-proxy \
    --ports=80


### TESTING TRAFFIC SENT TO OUR INSTANCES
