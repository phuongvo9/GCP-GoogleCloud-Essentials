export MY_ZONE=us-central1-a

gsutil cp gs://cloud-training/T-GCPWIN/mydeploy.yaml mydeploy.yaml

# Insert your Google Cloud Platform project ID into the file in place of the string PROJECT_ID
sed -i -e 's/PROJECT_ID/'$DEVSHELL_PROJECT_ID/ mydeploy.yaml

# Insert your assigned Google Cloud Platform zone into the file in place of the string ZONE
sed -i -e 's/ZONE/'$MY_ZONE/ mydeploy.yaml

cat mydeploy.yaml


# Build a deployment from the template:


gcloud deployment-manager deployments create my-first-depl --config mydeploy.yaml

nano mydeploy.yaml

gcloud deployment-manager deployments update my-first-depl --config mydeploy.yaml

student_01_a04746056
xXZ}10prib:ZI:>