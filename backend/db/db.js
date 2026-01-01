const mysql = require('mysql2');
const os = require('os');

const dbConfig = {
    host:'127.0.0.1',
    port: 3306,
    user:'tanvir',
    password: '',
    database:'PokemonVGC'
};

// socketpath only for macOS
if (process.platform === 'darwin') {
    dbConfig.socketPath = '/tmp/mysql.sock';
}

const db = mysql.createConnection(dbConfig);

db.connect((err)=>{
    if (err){
        console.error('Database connection failed:', err);
        return;
    }
    console.log('Connected to MySQL database(3306)')
});
module.exports=db;
