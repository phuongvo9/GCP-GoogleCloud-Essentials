# Create a Cloud Storage bucket and place an image into it

# Create a Cloud SQL instance and configure it

# Connect to the Cloud SQL instance from a web server

# Use the image in the Cloud Storage bucket on a web page

#------------------------------------------------------------------------------
# Portal > Marketplace > IIS > IIS Microsoft on Windows 2012 R2
#Get Project ID

#Create a Cloud Storage bucket using the gsutil
export LOCATION=ASIA
#export DEVSHELL_PROJECT_ID=qwiklabs-gcp-02-ebd00de3ea96


#make a bucket named after your project ID
    #DEVSHELL_PROJECT_ID environment variable contains your project ID
gsutil mb -l $LOCATION gs://$DEVSHELL_PROJECT_ID

# https://cloud.google.com/storage/docs/gsutil/commands/mb

#Retrieve a banner image from a publicly accessible Cloud Storage location (to cloud shell machine)
gsutil cp gs://cloud-training/gcpfci/my-excellent-blog.png my-excellent-blog.png
ls

#Copy the banner image to your newly created Cloud Storage bucket from cloud shell
gsutil cp my-excellent-blog.png gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png

#Modify the Access Control List of the object you just created so that it is readable by everyone:
gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png



#SQL >  Create SQL Server instance (~7 minutes creation)
# Add user account
# Connects > Public IP (Private IP is in preview mode)

#blog-db
#KEwO4MHqlhuDobpv

#Connect to Compute VM (set password)
#student_01_a04746056
#CX[7o9USGY/ts;Q
#blogdbuser
#CX[7o9USGY/ts;Q

#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#choco install -y webpi --version 5.1

cd C:\inetpub\wwwroot
notepad
<?php
    phpinfo();
?>

