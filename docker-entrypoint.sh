#!/bin/bash

# NOTE: Requires the `function.sh` script be sourced in the shell at runtime.

# Example:
#          > $ source ./function.sh



# Set Static Variables to Pre-Check
VAR_ARRAY=(
  "BUCKET_NAME" 
  "BACKEND_PATH"
  "BUCKET_REGION")

BASE_DIR="/terraform-module"
MODULE_DIR="env"
PROJECT_DIR="${BASE_DIR}/${MODULE_DIR}"



cd $BASE_DIR
source ./functions.sh

echo 
echo "Starting Variable Pre-Flight Checks..."
var_precheck

echo
echo -e "${ANSI_COLOR_WHITE}Pre-Flight Checks: ${ANSI_COLOR_GREEN}PASSED! ${ANSI_COLOR_BLUE}<- ${ANSI_COLOR_WHITE}Required Variables Already Set!"


echo
echo "Loading Terraform Binary..."
cd $PROJECT_DIR
tfenv install


echo
echo 
echo "Starting Deployment..."

echo
echo "Now Performing Terraform Init (Initialization of Backend and Provider Plugins)"
tf_init "$BUCKET_NAME" "${BACKEND_PATH}" "${BUCKET_REGION}"

echo
echo "Now Performing Terraform Validate (Validate/Lint)"
tf_validate
tf_fmt

echo
echo "Now Performing Terraform Plan (Unit Tests)"
tf_plan

echo
echo "Now Performing Terraform Apply (Provisioning)"
tf_apply

echo
echo
echo 'Workflow has Completed Successfully...'
