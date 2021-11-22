

gcloud app create --project=$DEVSHELL_PROJECT_ID
git clone https://github.com/GoogleCloudPlatform/python-docs-samples

cd python-docs-samples/appengine/standard_python3/hello_world

# Run Hello World application locally
sudo apt-get update
sudo apt-get install virtualenv
virtualenv -p python3 venv

source venv/bin/activate
pip install  -r requirements.txt

python main.py

# Deploy and run Hello World on App Engine
cd ~/python-docs-samples/appengine/standard_python3/hello_world
gcloud app deploy
gcloud app browse

#https://qwiklabs-gcp-02-87bb95f3e5c8.ue.r.appspot.com/