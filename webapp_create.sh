#!/bin/bash

# inputs ######################################################################################
# $1 - same name for a new resource group, a new Linx service plan, a new Linux site	      #
# $2 - ACR(Azure Container Registry) registry name 					      #
# $3 - docker image name and (optional)tag					              #
                                							      #	
# usage: ./webapp_create.sh [name] [registry] [image]  			 		      #
# result: create a new resource group, a new app service plan, a new site with same name      #
###############################################################################################

name=$1
registry=$2
image=$3

# step1: create a new resource group in "West US"
az group create --name "$name" --location "West US"

echo "Created a Resource Group"

# step2: create a new servcie plan in "West US"
az appservice plan create -g "$name" -n "$name" --is-linux --number-of-workers 1 --sku P2V2 --location "West US"

echo "Created an App Service Plan"

# step3: create a new Linux site 
az webapp create -g "$name" -p "$name" --name "$name" --deployment-container-image-name "nginx" 
az webapp config container set -n "$name" -g "$name" --docker-custom-image-name "$registry".azurecr.io/"$image" --docker-registry-server-url https://"$registry".azurecr.io --docker-registry-server-user "$registry" --docker-registry-server-password "n89eC5ZL6MIU/2z1iYm/cMlh0hfsiekc"

echo "Created a new Linux site: https://$name.azurewebsites.net"

# step4: warm the site
curl https://$name.azurewebsites.net

echo 
