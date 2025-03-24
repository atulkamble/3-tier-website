#!/bin/bash
sudo yum install -y mariadb-server git
sudo systemctl start mariadb
sudo systemctl enable mariadb
git clone https://github.com/your-username/3-tier-website.git
mysql -u root < 3-tier-website/database/init.sql