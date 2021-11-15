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



