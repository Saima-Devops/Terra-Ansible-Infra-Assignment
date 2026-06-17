#!/bin/bash

set -e

PROJECT_NAME="mern-devops-project"

echo "Creating project structure..."

mkdir -p \
    ${PROJECT_NAME}/terraform \
    ${PROJECT_NAME}/ansible/group_vars \
    ${PROJECT_NAME}/screenshots

touch ${PROJECT_NAME}/terraform/provider.tf
touch ${PROJECT_NAME}/terraform/variables.tf
touch ${PROJECT_NAME}/terraform/main.tf
touch ${PROJECT_NAME}/terraform/network.tf
touch ${PROJECT_NAME}/terraform/security.tf
touch ${PROJECT_NAME}/terraform/ec2.tf
touch ${PROJECT_NAME}/terraform/iam.tf
touch ${PROJECT_NAME}/terraform/outputs.tf

touch ${PROJECT_NAME}/ansible/inventory.ini
touch ${PROJECT_NAME}/ansible/webserver.yml
touch ${PROJECT_NAME}/ansible/mongodb.yml
touch ${PROJECT_NAME}/ansible/deploy.yml
touch ${PROJECT_NAME}/ansible/hardening.yml
touch ${PROJECT_NAME}/ansible/group_vars/all.yml

touch ${PROJECT_NAME}/README.md

echo "Project structure created successfully."

tree ${PROJECT_NAME} || find ${PROJECT_NAME}
