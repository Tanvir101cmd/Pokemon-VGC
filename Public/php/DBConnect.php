<?php
$servername = "127.0.0.1";
$username = "root"; //mysql -u root -p
$password = "123456";
$dbname = "PokemonVgc";
$port = 3310;

$conn = new mysqli($servername, $username, $password, $dbname, $port);

if($conn->connect_error){
	die("Connection failed: " . $conn->connect_error);
}
?>