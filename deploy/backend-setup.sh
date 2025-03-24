#!/bin/bash
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs git
git clone https://github.com/atulkamble/3-tier-website.git
cd 3-tier-website/backend
npm init -y
npm install express mysql2 cors
node server.js
