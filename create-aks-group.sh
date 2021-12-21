#!/bin/sh

AZURE_AD_GROUP_NAME="devopsthehardway-aks-group"
CURRENT_USER_OBJECTID=$(az ad signed-in-user show --query objectId -o tsv)

