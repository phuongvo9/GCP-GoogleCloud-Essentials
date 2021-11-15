gcloud compute networks create managementnet --project=qwiklabs-gcp-00-c519419159d3 --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional


gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-00-c519419159d3 --description=managementsubnet-us --range=10.130.0.0/20 --network=managementnet --region=us-central1

#------------------- Create the privatenet network
#Create VPC privatenet network
gcloud compute networks create privatenet --subnet-mode=custom
# create the privatesubnet-us
gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=us-central1 --range=172.16.0.0/24
# create the privatesubnet-eu
gcloud compute networks subnets create privatesubnet-eu --network=privatenet --region=europe-west4 --range=172.20.0.0/20

# List available VPC Networks

gcloud compute networks list

gcloud compute networks subnets list --sort-by=NETWORK


# Create the firewall rules for managementnet
gcloud compute --project=qwiklabs-gcp-00-c519419159d3 firewall-rules create managementnet-allow-icmp-ssh-rdp --description=managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

# Create the firewall rules for privatenet
gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0


# List VPC with sort VPC network
gcloud compute firewall-rules list --sort-by=NETWORK

# -------------- Create VM Instances

Create VM instances
Create two VM instances:

#managementnet-us-vm in managementsubnet-us

#privatenet-us-vm in privatesubnet-us

# Create VM in mgmt VPC
gcloud compute instances create managementnet-us-vm \
    --project=qwiklabs-gcp-00-c519419159d3 \
    --zone=us-central1-f --machine-type=n1-standard-1 \
    --network-interface=network-tier=PREMIUM,subnet=managementsubnet-us \
    --maintenance-policy=MIGRATE --service-account=341788628231-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --create-disk=auto-delete=yes,boot=yes,device-name=managementnet-us-vm,image=projects/debian-cloud/global/images/debian-10-buster-v20211105,mode=rw,size=10,type=projects/qwiklabs-gcp-00-c519419159d3/zones/us-central1-f/diskTypes/pd-balanced \
    --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any


# Create the privatenet-us-vm instance
gcloud compute instances create privatenet-us-vm \
    --zone=us-central1-f \
    --machine-type=n1-standard-1 \
    --subnet=privatesubnet-us

# List all VM instances (sorted by Zone)
gcloud compute instances list --sort-by=ZONE


# ------------------------Create a VM instance with multiple network interfaces

# Every instance in a VPC network has a default network interface
# Multiple network interfaces enable you to create configurations in which an instance connects directly to several VPC networks (up to 8 interfaces, depending on the instance's type).
gcloud compute instances create vm-appliance \
    --project=qwiklabs-gcp-00-c519419159d3 \
    --zone=us-central1-f --machine-type=n1-standard-4 \
    --network-interface=network-tier=PREMIUM,subnet=privatesubnet-us \
    --network-interface=network-tier=PREMIUM,subnet=mynetwork \
    --network-interface=network-tier=PREMIUM,subnet=managementsubnet-us \
    --maintenance-policy=MIGRATE --service-account=341788628231-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --create-disk=auto-delete=yes,boot=yes,device-name=vm-appliance,image=projects/debian-cloud/global/images/debian-10-buster-v20211105,mode=rw,size=10,type=projects/qwiklabs-gcp-00-c519419159d3/zones/us-central1-f/diskTypes/pd-balanced --no-shielded-secure-boot \
    --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
