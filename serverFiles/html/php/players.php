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

$players = "SELECT * FROM player";
$result = $conn->query($players);

$response = array();
$players = array();

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
	$name=$row["playerName"];
	$position=$row["position"];
	$age=$row["age"];
	$height=$row["height"];
	$school=$row["school"];
	$jerseyNum=$row["jerseyNum"];
	
	$players[] = array("Name"=> $name, "Position"=> $position, "Age"=> $age, "Height"=> $height, "School"=> $school, "jerseyNum"=> $jerseyNum);

	echo "Name: " . $name. ", Position: " . $position. ", Age: " . $age. ", Height: " . $height. ", School: " . $school. ", Jersey number: " . $jerseyNum. "<br>";
    }
} else {
	$posts[] = array();

	echo "0 results";
}

$response['PLAYERS'] = $players;

$fp = fopen('/var/www/html/json/players.json', 'w');
fwrite($fp, json_encode($response));
fclose($fp);

$conn->close();
?>
