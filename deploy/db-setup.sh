#!/bin/bash
sudo yum install mariadb105-devel
sudo systemctl start mariadb
sudo systemctl enable mariadb
git clone https://github.com/atulkamble/3-tier-website.git
mysql -u root < 3-tier-website/database/init.sql
