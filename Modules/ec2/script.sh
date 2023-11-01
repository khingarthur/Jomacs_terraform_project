#!/bin/bash
# Author: Frederick Arthur
# Date: 31/10/2023
# Purpose: This script is used to install nginx 


# Update system
sudo apt-get update
sudo apt-get upgrade 

# Install Nginx
sudo apt-get install nginx -y

# Create index.html with custom content
echo -e '<h1>JOMACS Terraform Project To Install Nginx Complete .</h1>
<h3>A Reverse Proxy Have Been Configured To Forward Requests From Port 80 To The Local Host.</h3>



<h3>Thank You!</h3>' > /var/www/html/index.html

# Start Nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Create reverse proxy server configuration
sudo tee /etc/nginx/sites-available/practice.conf <<-EOF
server {
  listen 80;

  location / {
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_cache_bypass \$http_upgrade;
    proxy_pass http://localhost:80/;
  }
}

EOF

# Enable the reverse proxy configuration
sudo ln -s /etc/nginx/sites-available/practice.conf /etc/nginx/sites-enabled/

# Restart Nginx to apply the changes
sudo systemctl restart nginx
