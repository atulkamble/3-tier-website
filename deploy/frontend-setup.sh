#!/bin/bash
sudo yum install -y httpd git
sudo systemctl start httpd
sudo systemctl enable httpd
cd /var/www/html
git clone https://github.com/your-username/3-tier-website.git
cp 3-tier-website/frontend/index.html .