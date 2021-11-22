

gcloud app create --project=$DEVSHELL_PROJECT_ID
git clone https://github.com/GoogleCloudPlatform/python-docs-samples

cd python-docs-samples/appengine/standard_python3/hello_world

#
sudo apt-get update
sudo apt-get install virtualenv
virtualenv -p python3 venv

source venv/bin/activate
pip install  -r requirements.txt

