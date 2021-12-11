require('dotenv').config();
const mysql = require('mysql');

// const { DB_HOST, DB_USER, DB_PASSWORD, DB_DATABASE } = process.env;

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  port: process.env.DB_PORT,
  multipleStatements: true,
});

db.connect((err) => {
  if (err) throw err;
});

module.exports = db;
