
export MY_ZONE=us-central1-a

gsutil cp gs://cloud-training/gcpfcoreinfra/mydeploy.yaml mydeploy.yaml

# sed command to replace the PROJECT_ID
sed -i -e "s/PROJECT_ID/$DEVSHELL_PROJECT_ID/" mydeploy.yaml
sed -i -e "s/ZONE/$MY_ZONE/" mydeploy.yaml

cat mydeploy.yaml


gcloud deployment-manager deployments create my-first-depl --config mydeploy.yaml
# Change startup script, value: "apt-get update" to  value: "apt-get update; apt-get install nginx-light -y"
nano mydeploy.yaml


      value: "apt-get update; apt-get install nginx-light -y"
dd if=/dev/urandom | gzip -9 >> /dev/null &

### Create a Monitoring workspace
# install both the Monitoring and Logging agents
curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
sudo bash install-monitoring-agent.sh


curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
sudo bash install-logging-agent.sh

kill %1