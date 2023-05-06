const fs = require("fs");
const { Pool } = require("pg");
const fastcsv = require("fast-csv");
require('dotenv').config();

let stream = fs.createReadStream("ev_locations.csv");
let lineCount = 0;
let csvStream = fastcsv
  .parse()
  .on("data", function(data) {
    lineCount++;
  })
  .on("end", function() {
    console.log(`Total number of rows in CSV file: ${lineCount}`);

    // create a new connection to the database
    const pool = new Pool({
      user: process.env.POSTGRES_USER,
      host: process.env.POSTGRES_HOST,
      database: process.env.POSTGRES_DB,
      password: process.env.POSTGRES_PW,
      port: process.env.POSTGRES_PORT,
    });

    pool.connect((err, client, done) => {
      if (err) throw err;

      try {
        client.query("SELECT COUNT(*) FROM ev_locations", (err, res) => {
          if (err) {
            console.log(err.stack);
          } else {
            console.log(`Total rows in table: ${res.rows[0].count}`);
          }
        });

        client.query("SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'ev_locations'", (err, res) => {
          if (err) {
            console.log(err.stack);
          } else {
            console.log("Table schema:");
            res.rows.forEach(row => {
              console.log(`${row.column_name} - ${row.data_type}`);
            });
          }

          done();
        });
      } finally {
        pool.end();
      }
    });
  });

stream.pipe(csvStream);
