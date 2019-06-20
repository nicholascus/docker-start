<?php
$host = getenv('DB_HOST');
$dbname = getenv('DB_NAME');
$user = getenv('DB_USER');
$pass = getenv('DB_PASSWORD');
$pdo = new PDO("mysql:host=$host;dbname=$dbname",$user,$pass);
echo 'MySQL version: ' . $pdo->query('select version()')->fetchColumn() . PHP_EOL;
phpinfo();
