const mysql = require('mysql2');
const db=mysql.createConnection({
   socketPath: '/tmp/mysql.sock',
    host:'localhost',
    port:3306,
    user:'tanvir',
    password:'linux',
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
