
gcloud config list project
gcloud config set compute/zone us-central1-a
gcloud config set compute/region us-central1

# Create multiple web server instances

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

