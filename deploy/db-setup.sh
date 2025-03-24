#!/bin/bash
sudo yum install mysql-selinux.noarch -y
sudo yum install mariadb105-server.x86_64 -y
sudo systemctl enable --now mariadb
sudo systemctl restart mariadb
git clone https://github.com/atulkamble/3-tier-website.git
mysql -u root < 3-tier-website/database/init.sql
