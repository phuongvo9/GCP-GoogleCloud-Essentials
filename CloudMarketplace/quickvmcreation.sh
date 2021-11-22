

gcloud compute zones list | grep us-central1
gcloud config set compute/zone us-central1-b


gcloud compute instances create "my-vm-2" \
--machine-type "n1-standard-1" \
--image-project "debian-cloud" \
--image-family "debian-10" \
--subnet "default"