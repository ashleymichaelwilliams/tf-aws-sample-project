#!/bin/bash


# ANSI Colors
ANSI_COLOR_RED='\033[0;31m'
ANSI_COLOR_GREEN='\033[0;32m'
ANSI_COLOR_BLUE='\033[1;34m'
ANSI_COLOR_WHITE='\033[0;37m'
ANSI_COLOR_CYAN='\033[1;36m'
ANSI_COLOR_PURPLE='\033[1;35m'



# Function to Check if Variables are Set
variable_check() {
    VAR_INPUT="$1"

    if [ -z "${!VAR_INPUT}" ]
    then
      echo "Variable $VAR_INPUT NOT Set!"
      return 1
    else
      export VAR_VALUE=$(eval 'echo "${'"$VAR_INPUT"'}"')
      echo "Variable ${VAR_INPUT} set to '$VAR_VALUE'"
      return 0
    fi
}



# Pre-Check Loop on Variable Array
var_precheck() {
  for CURR_VAR in "${VAR_ARRAY[@]}"
  do 
    echo
    echo "Processing Variable: $CURR_VAR"
    variable_check $CURR_VAR
    if [ $? -ne 0 ]
    then
      exit 1
    fi
  done
}



# Terraform Functions
tf_init() {
    terraform init -backend-config=bucket=$1 -backend-config=key=$2 -backend-config=region=$3
    if [ $? -ne 0 ]
    then
      exit 1
    fi
}


tf_validate() {
    terraform validate -no-color
    if [ $? -ne 0 ]
    then
      exit 1
    fi
}


tf_fmt() {
    terraform fmt --check -recursive -no-color
    if [ $? -ne 0 ]
    then
      exit 1
    fi
}


tf_plan() {
    terraform plan -no-color -out=tfplan.out
    if [ $? -ne 0 ]
    then
      exit 1
    fi
}


tf_apply() {
    terraform apply -auto-approve tfplan.out
    if [ $? -ne 0 ]
    then
      exit 1
    fi
}


tf_destroy() {
    terraform destroy -auto-approve
    if [ $? -ne 0 ]
    then
      exit 1
    fi
}
