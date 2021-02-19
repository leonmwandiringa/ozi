#!/bin/bash

echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------"
echo "------------Tangent solutions - Infrastructure automation------------"
echo "-------- initial terraform state management and state locks --------"
echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------
"

# define Resource name
if [ -z "$1" ]
  then
    echo "Resource name is required, please enter bucket name"
    sleep 5s
    exit 0
fi
RESOURCE_NAME=$1

# define bucket region
if [ -z "$2" ]
  then
    echo "Bucket region is required, please enter bucket region"
    sleep 5s
    exit 0
fi
BUCKET_REGION=$2

# define AWS profile
if [ -z "$3" ]
  then
    echo "aws profile was not provided, using default"
    AWS_PROFILE=default
  else
    echo "aws profile was provided, using profile $3"
    AWS_PROFILE=$3
fi

declare -x PROFILE_COMMAND=""
if [ "$AWS_PROFILE" != "default" ]
  then 
    $PROFILE_COMMAND="--profile $AWS_PROFILE"
fi

datetime=`TZ='Africa/Johannesburg' date`
CREATIONTIME="$datetime"


# -------------------------------------------------------------------------------------------------------------
# create bucket
echo $'\e[1;34m'"------------------- initiating infrastructure bucket ------------------------
"$'\e[0m'

aws s3 mb s3://$RESOURCE_NAME \
    --region $BUCKET_REGION \
    $PROFILE_COMMAND


#enable encryption for bucket
echo $'\e[1;34m'"------------------- Enabling Encryption for Bucket $RESOURCE_NAME ------------------------
"$'\e[0m'

aws s3api put-bucket-encryption --bucket $RESOURCE_NAME \
    --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}' \
    $PROFILE_COMMAND


#Access for bucket
echo $'\e[1;34m'"------------------- Access for Bucket $RESOURCE_NAME ------------------------
"$'\e[0m'

aws s3api put-public-access-block --bucket $RESOURCE_NAME \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" \
    $PROFILE_COMMAND


#enable versioning for bucket
echo $'\e[1;34m'"------------------- Enabling Versioning for Bucket $RESOURCE_NAME ------------------------
"$'\e[0m'

aws s3api put-bucket-versioning --bucket $RESOURCE_NAME \
    --versioning-configuration Status=Enabled \
    $PROFILE_COMMAND


#enable Tagging for bucket
echo $'\e[1;34m'"------------------- Enabling Tagging for Bucket $RESOURCE_NAME ------------------------
"$'\e[0m'

aws s3api put-bucket-tagging --bucket $RESOURCE_NAME \
    --tagging TagSet="[{Key=Author,Value=\"Tangent Solutions\"},{Key=Name,Value=\"$RESOURCE_NAME\"}]" \
    $PROFILE_COMMAND

# ----------------------------------------------------------------------------------------------------


#enable Tagging for bucket
echo $'\e[1;34m'"------------------- Create table for $RESOURCE_NAME ------------------------
"$'\e[0m'

aws dynamodb create-table --table-name $RESOURCE_NAME \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --tags Key=Author,Value="Tangent Solutions" Key=Name,Value="$RESOURCE_NAME" \
    --region $BUCKET_REGION \
    $PROFILE_COMMAND

echo "$DYNAMODB_CREATION_RESULTS"
echo $'\e[1;34m'"------------------- Done running Infrastructure provision prerequisite resources ------------------------
"$'\e[0m'