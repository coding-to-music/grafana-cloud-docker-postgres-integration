require("dotenv").config();

const { Pool } = require("pg");

// Create a new pool instance with your PostgreSQL connection details
const pool = new Pool({
  connectionString: process.env.POSTGRES_URL,
  ssl: true,
});

// the order is important - the updates for decimals need to be done second for unaccepted_length_int and width_int
const updateStatements = [
"UPDATE street SET unaccepted_length_int = CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER) WHERE CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER) > 0",
"UPDATE street SET unaccepted_length_int = CAST(REGEXP_REPLACE(street.unacceptedlength, '(\\d+)\\..*', '\\1') AS INTEGER) WHERE public.street.unacceptedlength ~ '[^\\d]' AND   public.street.unacceptedlength ~ '[\\.]' ",
"UPDATE street SET length_int = CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER) WHERE CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER) > 0",
"UPDATE street SET width_int = CAST(REGEXP_REPLACE(public.street.width, '\\D', '', 'g') AS INTEGER) WHERE CAST(REGEXP_REPLACE(public.street.width, '\\D', '', 'g') AS INTEGER) > 0",
"UPDATE street SET width_int = CAST(REGEXP_REPLACE(street.width, '(\\d+)\\..*', '\\1') AS INTEGER) WHERE street.width ~ '\\.' ",
"UPDATE street SET accepted_area_int = length_int * width_int WHERE length_int > 0 AND   width_int > 0",
"UPDATE street SET unaccepted_area_int = unaccepted_length_int * width_int WHERE unaccepted_length_int > 0 AND   width_int > 0",
"UPDATE street SET width_int = ( CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) + CAST(SPLIT_PART(public.street.width, '-', 2) AS INTEGER)) / 2 WHERE public.street.width ~ '[^d]' AND   public.street.width ~ '[-]'",
"UPDATE street SET year_added_int = CAST(regexp_replace(street.date, '\\D', '', 'g') AS INTEGER) WHERE CAST(regexp_replace(street.date, '\\D', '', 'g') AS INTEGER) > 0",
];

// Function to execute the update statements
async function executeUpdateStatements() {
  const client = await pool.connect();
  try {
    await client.query("BEGIN"); // Begin transaction

    for (const statement of updateStatements) {
      await client.query(statement);
    }

    await client.query("COMMIT"); // Commit transaction
    console.log("Update statements executed successfully.");
  } catch (error) {
    await client.query("ROLLBACK"); // Rollback transaction
    console.error("Error executing update statements:", error);
  } finally {
    client.release(); // Release the client back to the pool
    pool.end(); // Close the connection pool
  }
}

// Call the function to execute the update statements
executeUpdateStatements();
