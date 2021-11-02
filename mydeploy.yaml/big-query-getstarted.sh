# Load data from Cloud Storage into BigQuery.

# Perform a query on the data in BigQuery.


# gsutil cp gs://cloud-training/gcpfci/access_log.csv access_log.csv
# export LOCATION=US
# gsutil mb -l $LOCATION gs://$DEVSHELL_PROJECT_ID

# gsutil cp access_log.csv gs://$DEVSHELL_PROJECT_ID/access_log.csv

# gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/access_log.csv

# gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/access_log.csv
# Updated ACL on gs://qwiklabs-gcp-02-bea85aa0572f/access_log.csv


gsutil cp gs://cloud-training/gcpfci/access_log.csv access_log.csv
export LOCATION=US
gsutil mb -l $LOCATION gs://$DEVSHELL_PROJECT_ID

gsutil cp access_log.csv gs://$DEVSHELL_PROJECT_ID/access_log.csv

gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/access_log.csv

gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/access_log.csv
Updated ACL on gs://qwiklabs-gcp-02-bea85aa0572f/access_log.csv


bq query "select string_field_10 as request, count(*) as requestcount from logdata.accesslog group by request order by requestcount desc"