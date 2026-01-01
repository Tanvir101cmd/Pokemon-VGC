const express = require('express');
const router = express.Router();
const db = require('../db/db'); // Points to db.js

router.post('/login', (req, res) => {
    const { username, password } = req.body;

    // Use 'name' and 'pass' from your database.sql
    const query = 'SELECT * FROM users WHERE name = ? AND pass = ?';
    
    db.execute(query, [username, password], (err, results) => {
        if (err) {
            return res.status(500).json({ success: false, message: "Database error" });
        }

        if (results.length > 0) {
            res.json({ success: true, trainerName: results[0].name });
        } else {
            res.status(401).json({ success: false, message: "Invalid Trainer Name or Password" });
        }
    });
});

module.exports = router;