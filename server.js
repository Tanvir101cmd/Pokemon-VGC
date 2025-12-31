const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();
app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
    res.send('Backend is running');
});

/* ============================================================
   REGION & ENCOUNTER ROUTES (FIXED: Moved to Top Level)
   ============================================================ */

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

/* ============================================================
   POKEMON SEARCH ROUTES (FIXED: p.id changed to p.sid)
   ============================================================ */

app.get('/pokemon/search', (req, res) => {
    const name = req.query.name;

    const sql = `
        SELECT 
            p.sid,
            p.name,
            GROUP_CONCAT(DISTINCT t.type_name) AS types
        FROM pokemon p
        LEFT JOIN pokemon_types pt ON p.sid = pt.pokemon_sid
        LEFT JOIN types t ON pt.type_name = t.name
        WHERE p.name LIKE ?
        GROUP BY p.sid
    `;

    db.query(sql, [`%${name}%`], (err, result) => {
        if (err) return res.status(500).json(err);
        res.json(result);
    });
});

app.get('/pokemon', (req, res) => {
    const { name, type, limit = 20, offset = 0 } = req.query;

    let sql = `
        SELECT 
            p.sid,
            p.name,
            GROUP_CONCAT(DISTINCT t.type_name) AS types
        FROM pokemon p
        LEFT JOIN pokemon_types pt ON p.sid = pt.pokemon_sid
        LEFT JOIN types t ON pt.type_name = t.name
        WHERE 1=1
    `;

    const params = [];
    if (name) {
        sql += ` AND p.name LIKE ?`;
        params.push(`%${name}%`);
    }
    if (type) {
        sql += ` AND t.type_name = ?`;
        params.push(type);
    }

    sql += `
        GROUP BY p.sid
        ORDER BY p.sid
        LIMIT ? OFFSET ?
    `;

    params.push(Number(limit), Number(offset));

    db.query(sql, params, (err, result) => {
        if (err) return res.status(500).json(err);
        res.json(result);
    });
});

app.listen(3000, () => {
    console.log('Server running on http://localhost:3000');
});
