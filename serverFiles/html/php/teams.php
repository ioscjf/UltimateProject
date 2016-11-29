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

$teams = "SELECT * FROM team";
$result = $conn->query($teams);

$response = array();
$teams = array();

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
	$name=$row["teamName"];
	$school=$row["school"];
	$division=$row["competitionDivision"];
	$year=$row["year"];
	$state=$row["state"];
	$region=$row["region"];
	$conference=$row["conference"];       
	
	$teams[] = array("Team"=> $name, "School"=> $school, "Division"=> $division, "Year"=> $year, "State"=> $state, "Region"=> $region, "Conference"=> $conference);
    
	echo "Team: " . $name. ", School: " . $school. ", Division: " . $division. ", Year: " . $year. ", State: " . $state. ", Region: " . $region. ", Conference: " . $conference. "<br>";
    }
} else {
	$posts[] = array();

	echo "0 results";
}

$response['TEAMS'] = $teams;

$fp = fopen('/var/www/html/json/teams.json', 'w');
fwrite($fp, json_encode($response));
fclose($fp);

$conn->close();
?>
