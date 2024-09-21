#!/bin/bash

AMI_ID="ami-0b4f379183e5706b9"
SG_ID="sg-0efaa853ee917a890"
INSTANCES=("web" "catalogue" "cart" "payment" "shipping" "redis" "mysql" "mongodb" "rabbitmq" "user" "dispatch")
HOSTED_ZONE_ID="Z04039613RABGV7GUAUIJ"
DOMAIN_NAME="roboriya.shop"

for i in "${INSTANCES[@]}"
do 

if [[ "$i" == "MONGODB" ||  "$i" == "MYSQL"  ||  "$i" == "SHIPPING" ]]
then
    INSTANCE_TYPE="t3.small"
else    
    INSTANCE_TYPE="t2.micro"
fi


IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI_ID  --instance-type $INSTANCE_TYPE  --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)

# --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --output text

echo "$i:$IP_ADDRESS"


aws route53 change-resource-record-sets \
  --hosted-zone-id "$HOSTED_ZONE_ID" \
  --change-batch '
  {
    "Comment": "Creating a record set for cognito endpoint"
    ,"Changes": [{
      "Action"              : "CREATE"
      ,"ResourceRecordSet"  : {
        "Name"              : "$i.$DOMAIN_NAME"
        ,"Type"             : "A"
        ,"TTL"              : 120
        ,"ResourceRecords"  : [{
            "Value"         : "$IP_ADDRESS"
        }]
      }
    }]
  } '
done