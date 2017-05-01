<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: appplication/json; charset=UTF-8");

$servername = "localhost";
$username = "admin";
$password = "frisbee";
$dbname = "finalDatabase";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$stats = "SELECT * FROM stats";
$result = $conn->query($stats);

if ($result->num_rows > 0) {
    // output data of each row
    
    $outp = "";

    while($rs = $result->fetch_array(MYSQLI_ASSOC)) {
	if ($outp != "") {$outp .= ",";}
	$outp .= '{"scores":"' . $rs["scores"] . '",';
	$outp .= '"assists":"' . $rs["assists"] . '",';
	$outp .= '"completions":"' . $rs["completions"] . '",';
	$outp .= '"throwingErrors":"' . $rs["throwingErrors"] . '",';
	$outp .= '"drops":"' . $rs["drops"] . '",';
	$outp .= '"ds":"' . $rs["ds"] . '",';
	$outp .= '"goallineThrowingErrors":"' . $rs["goallineThrowingErrors"] . '",';
	$outp .= '"goallineDs":"' . $rs["goallineDs"] . '",';
	$outp .= '"fouls":"' . $rs["fouls"] . '",';
	$outp .= '"pulls":"' . $rs["pulls"] . '",';
	$outp .= '"pullsOutOfBounds":"' . $rs["pullsOutOfBounds"] . '",';
	$outp .= '"offensivePointsPlayed":"' . $rs["offensivePointsPlayed"] . '",';
	$outp .= '"defensivePointsPlayed":"' . $rs["defensivePointsPlayed"] . '"}';
	
    }
	$outp = '{"STATS":['.$outp.']}';

} else {
	$outp = '{STATS":['.$outp.']}';
}

$conn->close();

echo($outp);
?>
