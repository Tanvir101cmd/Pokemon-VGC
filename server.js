const express=require('express');
const cors = require('cors');
const db=require('./backend/db/db');
// Unused 
// const checkTypes = require('./backend/utils/check_types');

const app = express();
app.use(cors());
app.use(express.json());

app.get('/',(req,res)=>{
    res.send('Backend is running');
});

// To view region encounters
app.get('/region/encounters', (req, res) => {
    const regionName = req.query.name;

    const sql = `
        SELECT 
            r.description AS region_desc,
            p.name AS pokemon_name,
            p.catch_rate,
            e.encounter_rate,
            e.method
        FROM regions r
        LEFT JOIN encounters e ON r.id = e.region_id
        LEFT JOIN pokemon p ON e.pokemon_sid = p.sid
        WHERE r.name = ?
    `;

    db.query(sql, [regionName], (err, result) => {
        if (err) {
            console.error("Database error:", err);
            return res.status(500).json({ error: "Internal Server Error" });
        }
        res.json(result);
    });
});


// Pokemon search queries
app.get('/pokemon/search', (req, res) => {
  const name = req.query.name || '';

  const sql = `
    SELECT 
      p.sid AS id,
      p.name,
      pt.type_name,
      pa.ability_name
    FROM pokemon p
    LEFT JOIN pokemon_types pt ON p.sid = pt.pokemon_sid
    LEFT JOIN types t ON pt.type_name = t.name
    LEFT JOIN pokemon_abilities pa ON p.sid = pa.pokemon_sid
    WHERE p.name LIKE ?
    LIMIT 100
  `;

  db.query(sql, [`%${name}%`], (err, result) => {
    if (err) return res.status(500).json(err);
    res.json(result);
  });
});

app.get('/pokemon', (req, res) => {
  const { search = '', type = '' } = req.query;

  let sql = `
    SELECT 
      p.sid AS id,
      p.name,
      pt.type_name,
      pt.type_name1
    FROM pokemon p
    LEFT JOIN pokemon_types pt ON p.sid = pt.pokemon_sid
    WHERE p.name LIKE ?
  `;

  const params = [`%${search}%`];

  if (type) {
    sql += ` AND p.sid IN (
      SELECT pt2.pokemon_sid
      FROM pokemon_types pt2
      WHERE pt2.type_name = ?
    )`;
    params.push(type);
  }

  sql += `
    ORDER BY p.sid
  `;

  db.query(sql, params, (err, results) => {
    if (err) return res.status(500).json(err)
    const map = new Map();
    (results || []).forEach(r => {
      const id = r.id;
      if (!map.has(id)) map.set(id, { id: r.id, name: r.name, types: [] });
      const entry = map.get(id);
      if (r.type_name) entry.types.push(r.type_name);
      if (r.type_name1) entry.types.push(r.type_name1);
    });
    const payload = Array.from(map.values()).map(e => {
      e.types = Array.from(new Set((e.types || []).map(t => String(t).trim()).filter(Boolean)));
      return e;
    });

    res.json(payload);
  });
});

app.get('/types', (req, res) => {
  const sql = `SELECT name AS type_name FROM types ORDER BY name`;
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json(err);
    res.json(results);
  });
});

// Detailed pokemon 
app.get('/pokemon/:id', (req, res) => {
  const id = req.params.id;

  // 1) basic info
  const qPokemon = `SELECT sid AS id, name FROM pokemon WHERE sid = ? LIMIT 1`;
  db.query(qPokemon, [id], (err, rows) => {
    if (err) return res.status(500).json({ error: err });
    if (!rows || rows.length === 0) return res.status(404).json({ error: 'Not found' });

    const pokemon = rows[0];

    // 2) types 
    const qTypes = `SELECT type_name, type_name1 FROM pokemon_types WHERE pokemon_sid = ?`;
    db.query(qTypes, [id], (err2, typesRows) => {
      if (err2) return res.status(500).json({ error: err2 });
      const all = [];
      (typesRows || []).forEach(r => {
        if (r.type_name) all.push(r.type_name);
        if (r.type_name1) all.push(r.type_name1);
      });
      pokemon.types = Array.from(new Set(all.map(t => String(t).trim()).filter(Boolean)));

      // 3) abilities
      const qAbilities = `SELECT ability_name FROM pokemon_abilities WHERE pokemon_sid = ?`;
      db.query(qAbilities, [id], (err3, abilityRows) => {
        if (err3) return res.status(500).json({ error: err3 });
        pokemon.abilities = (abilityRows || []).map(r => r.ability_name);

        // 4) base stats (bst table)
        const qStats = `SELECT hp, attack, sp_atk, defence, sp_def, spd FROM bst WHERE pokemon_sid = ? LIMIT 1`;
        db.query(qStats, [id], (errStats, statsRows) => {
          if (errStats) {
            pokemon.stats = {};
          } else if (statsRows && statsRows.length > 0) {
            const s = statsRows[0];
            pokemon.stats = {
              hp: s.hp,
              attack: s.attack,
              sp_atk: s.sp_atk,
              defence: s.defence,
              sp_def: s.sp_def,
              spd: s.spd
            };
          } else {
            pokemon.stats = {};
          }

          // 5) moves 
          const qMoves = `
            SELECT m.code, m.name, m.type_name AS type, m.power, m.accuracy, m.category
            FROM pokemon_moves pm
            JOIN moves m ON pm.move_code = m.code
            WHERE pm.pokemon_sid = ?
            LIMIT 500
          `;

          db.query(qMoves, [id], (err4, moveRows) => {
            if (err4) {
              // if table missing or other issue, don't fail — return empty moves
              pokemon.moves = [];
              return res.json(pokemon);
            }
            pokemon.moves = (moveRows || []).map(r => ({ code: r.code, name: r.name, type: r.type, power: r.power, accuracy: r.accuracy, category: r.category }));
            return res.json(pokemon);
          });
        });
      });
    });
  });
});

app.listen(3000,()=>{
    console.log('Server running on http://localhost:3000');
});
