#!/bin/bash

# exit when any command fails
set -e

new_ver=$1

echo "new version: $new_ver"

# Simulate release of the new docker images
docker tag nginx:1.23.3 medrh11/nginx:$new_ver

# Push new version to dockerhub
docker push medrh11/nginx:$new_ver

# Create temporary folder
tmp_dir=$(mktemp -d)
echo $tmp_dir

# Clone GitHub repo
git clone git@github.com:MeD1100/Devops_proj_pers_CD_private.git $tmp_dir

# Update image tag
sed -i '' -e "s/medrh11\/nginx:.*/medrh11\/nginx:$new_ver/g" $tmp_dir/terraform_prod/k8s/1-deployment.yaml

# Commit and push
cd $tmp_dir
git add .
git commit -m "Update image to $new_ver"
git push

# Optionally on build agents - remove folder
rm -rf $tmp_dir