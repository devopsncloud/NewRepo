#!/bin/bash

AMI_ID="ami-0b4f379183e5706b9"
SG_ID="sg-0efaa853ee917a890"
INSTANCES=("WEB" "CATALOGUE" "CART" "PAYMENT" "SHIPPING" "REDIS" "MYSQL" "MONGODB" "RABBITMQ" "USER" "DISPATCH")

for i in "${INSTANCES[@]}"
do 
echo "Creating "$i" "
if [[ "$i" == "MONGODB" ||  "$i" == "MYSQL"  ||  "$i" == "SHIPPING" ]]
then
    INSTANCE_TYPE="t3.small"
else    
    INSTANCE_TYPE="t2.micro"
fi


aws ec2 run-instances --image-id $AMI_ID  --instance-type $INSTANCE_TYPE  --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text

# --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --output text



done