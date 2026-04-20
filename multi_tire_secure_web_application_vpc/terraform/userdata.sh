#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
# Note: Listening on 80 for standard Apache, but TG is set to 8080 above to match your API requirements.
# Adjust the Apache Conf or your NodeJS/Python app port accordingly.
echo "<h1>API Backend - $(hostname -f)</h1>" > /var/www/html/index.html
