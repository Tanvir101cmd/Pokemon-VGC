const db = require('../db/db');

const sid = process.argv[2] || 6;
const sql = 'SELECT * FROM pokemon_types WHERE pokemon_sid = ?';

db.query(sql, [sid], (err, rows) => {
  if (err) {
    console.error('Query error:', err);
    process.exit(1);
  }
  console.log('Rows for pokemon_sid=' + sid + ':');
  console.log(JSON.stringify(rows, null, 2));
  process.exit(0);
});
