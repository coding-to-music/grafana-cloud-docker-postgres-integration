const { Pool } = require("pg");
require('dotenv').config();

const pool = new Pool({
  user: process.env.POSTGRES_USER,
  host: process.env.POSTGRES_HOST,
  database: process.env.POSTGRES_DB,
  password: process.env.POSTGRES_PW,
  port: process.env.POSTGRES_PORT,
});

(async () => {
  try {
    const { rows: rowCount } = await pool.query('SELECT COUNT(*) FROM ev_locations');
    console.log(`Row count: ${rowCount[0].count}`);

    const { rows: schema } = await pool.query(`
      SELECT column_name, data_type, character_maximum_length
      FROM information_schema.columns
      WHERE table_name = 'ev_locations'
      ORDER BY ordinal_position;
    `);

    const schemaString = schema.map(column => {
      const dataType = column.data_type === 'character varying' ? `${column.data_type}(${column.character_maximum_length})` : column.data_type;
      return `${column.column_name} ${dataType}`;
    }).join(",\n        ");

    console.log(`Schema:\nCREATE TABLE ev_locations (\n        ${schemaString},\n        CONSTRAINT "ev_locations_pkey" PRIMARY KEY ("id")\n      );`);
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await pool.end();
  }
})();
