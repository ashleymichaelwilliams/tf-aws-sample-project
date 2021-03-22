# tf-aws-sample-project

<br>

## Project Overview

#### Summary: This is an example project for a simple Terraform module for provisioning resources in AWS while storing the TF State data in an S3 Bucket.

<br>

### Required Installed Software:
- Docker Desktop (PC/Mac)

<br><br>


## Instructions

### Step 1: Set Required Variables (AWS Credential)
```
export AWS_ACCESS_KEY_ID="<YOURS_GOES_HERE>"
export AWS_SECRET_ACCESS_KEY="<YOURS_GOES_HERE>"
export AWS_SESSION_TOKEN="<YOURS_GOES_HERE>"
```


### Step 2: Build Docker Container Image
```
docker build -t tf-deploy .
```


### Step 3: Start/Run Docker Container (Interactive Mode)
```
docker run -ti --entrypoint '' \
 --env-file=example.env \
 -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
 -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
 -e AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN} \
 tf-deploy bash
```


### Step 4: Start Terraform Provisioning Workflow
```
/docker-entrypoint.sh
```


### Step 5: Decommision/Destroy (Optional)
```
source /terraform-module/functions.sh
cd /terraform-module/env/
tf_destroy
```
