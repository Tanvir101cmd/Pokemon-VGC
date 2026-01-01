const mysql = require('mysql2');
const db=mysql.createConnection({
    // For macOS only
    socketPath: '/tmp/mysql.sock',
    // For windows or others delete the above line

    host:'127.0.0.1',
    port: 3306,
    user:'tanvir',
    password: 'linux',
    database:'PokemonVGC'
});
db.connect((err)=>{
    if (err){
        console.error('Database connection failed:', err);
        return;
    }
    console.log('Connected to MySQL database(3306)')
});
module.exports=db;
