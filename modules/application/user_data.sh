#!/bin/bash
COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
COMPUTE_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
echo "This message was generated on instance $${COMPUTE_INSTANCE_ID} with the following UUID $${COMPUTE_MACHINE_UUID}" > /var/www/html/index.html
yum install -y httpd
systemctl start httpd
systemctl enable httpd
