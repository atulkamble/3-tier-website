# ec2-3-tier-website-project
Complete guide with **code structure** and **documentation** to create and host a **3-tier website on EC2** with **Git** integration:

---

## 📦 Project Structure

```
3-tier-website/
├── frontend/
│   └── index.html
├── backend/
│   └── server.js (Node.js app)
├── database/
│   └── init.sql
├── README.md
└── deploy/
    ├── frontend-setup.sh
    ├── backend-setup.sh
    └── db-setup.sh
```
```
git clone https://github.com/atulkamble/aws-3-tier-website.git
cd aws-3-tier-websitee
```
---

## 1️⃣ Frontend (Presentation Layer)

**index.html**
```html
<!DOCTYPE html>
<html>
<head>
  <title>My 3-Tier Website</title>
</head>
<body>
  <h1>Welcome to My 3-Tier Web App</h1>
  <p>Data from backend: <span id="data"></span></p>
  <script>
    fetch('http://<backend-ec2-ip>:3000/data')
      .then(res => res.json())
      .then(data => {
        document.getElementById('data').innerText = data.message;
      });
  </script>
</body>
</html>
```

---

## 2️⃣ Backend (Application Layer)

**server.js (Node.js)**
```js
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());

const db = mysql.createConnection({
  host: '<db-ec2-private-ip>',
  user: 'admin',
  password: 'password',
  database: 'myapp'
});

app.get('/data', (req, res) => {
  db.query('SELECT message FROM info LIMIT 1', (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: result[0].message });
  });
});

app.listen(3000, () => console.log('Server running on port 3000'));
```

---

## 3️⃣ Database Layer (MySQL)

**init.sql**
```sql
CREATE DATABASE IF NOT EXISTS myapp;
USE myapp;
CREATE TABLE IF NOT EXISTS info (
  id INT AUTO_INCREMENT PRIMARY KEY,
  message VARCHAR(255)
);
INSERT INTO info (message) VALUES ('Hello from MySQL Database!');
```

---

## 🔧 4️⃣ EC2 Setup Scripts

**deploy/frontend-setup.sh**
```bash
#!/bin/bash
sudo yum install -y httpd git
sudo systemctl start httpd
sudo systemctl enable httpd
cd /var/www/html
git clone https://github.com/atulkamble/3-tier-website.git
cp 3-tier-website/frontend/index.html .
```

**deploy/backend-setup.sh**
```bash
#!/bin/bash
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs git
git clone https://github.com/atulkamble/3-tier-website.git
cd 3-tier-website/backend
npm init -y
npm install express mysql2 cors
node server.js
```

**deploy/db-setup.sh**
```bash
#!/bin/bash
sudo yum install -y mariadb-server git
sudo systemctl start mariadb
sudo systemctl enable mariadb
git clone https://github.com/atulkamble/3-tier-website.git
mysql -u root < 3-tier-website/database/init.sql
```

---

```markdown
# 3-Tier Website on EC2

## Architecture
- **Frontend:** HTML (Apache HTTPD)
- **Backend:** Node.js (Express)
- **Database:** MySQL (MariaDB)

## Setup Instructions

### Step 1: Launch EC2 Instances
- Frontend (HTTPD)
- Backend (Node.js)
- Database (MySQL)

### Step 2: Git Clone
On each instance, clone the repo:
```bash
git clone https://github.com/atulkamble/aws-3-tier-website.git
cd aws-3-tier-website
```

### Step 3: Run Setup Scripts
Run the respective setup scripts:
```bash
sudo bash deploy/frontend-setup.sh
sudo bash deploy/backend-setup.sh
sudo bash deploy/db-setup.sh
```

### Step 4: Test
- Access Frontend: `http://<frontend-ec2-public-ip>`
- Backend should fetch data from the DB

```
