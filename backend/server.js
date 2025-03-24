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