<?php
$servername = "localhost";
$username = "admin";
$password = "frisbee";
$dbname = "test";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$stats = "SELECT * FROM stats";
$result = $conn->query($stats);

$response = array();
$stats = array();

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
	$name=$row["playerName"];
	$year=$row["year"];
	$scores=$row["scores"];
	$assists=$row["assists"];
	$offensivePointsPlayed=$row["offensivePointsPlayed"];
	$defensivePointsPlayed=$row["defensivePointsPlayed"];
	$drops = $row["drops"];
	$catches = $row["catches"];
	$completions = $row["completions"];
	
	$stats[] = array("Name"=> $name, "Year"=> $year, "Scores"=> $scores, "Assists"=> $assists, "OffensivePointsPlayed"=> $offensivePointsPlayed, "DefensivePointsPlayed"=> $defensivePointsPlayed, "Drops"=> $drops, "Catches"=> $catches, "Completions"=> $completions);
    
	echo "Name: " . $name. ", Year: " . $year. ", Scores: " . $scores. ", Assists: " . $assists. ", Offensive Points Played: " . $offensivePointsPlayed . ", Defensive Points Played: " . $defensivePointsPlayed. ", Drops: " . $drops. ", Catches: " . $catches. ", Completions: " . $completions. "<br>";
    }
} else {
	$posts[] = array();

	echo "0 results";
}

$response['STATS'] = $stats;

$fp = fopen('/var/www/html/json/stats.json', 'w');
fwrite($fp, json_encode($response));
fclose($fp);

$conn->close();
?>
