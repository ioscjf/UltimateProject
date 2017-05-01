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

$teams = "SELECT * FROM team";
$result = $conn->query($teams);

if ($result->num_rows > 0) {
    // output data of each row
    
    $outp = "";

    while($rs = $result->fetch_array(MYSQLI_ASSOC)) {
	if ($outp != "") {$outp .= ",";}
	$outp .= '{"teamName":"' . $rs["teamName"] . '",';
	$outp .= '"school":"' . $rs["school"] . '",';
	$outp .= '"competitionDivision":"' . $rs["competitionDivision"] . '",';
	$outp .= '"city":"' . $rs["city"] . '",';
	$outp .= '"state":"' . $rs["state"] . '",';
	$outp .= '"region":"' . $rs["region"] . '",';
	$outp .= '"genderDivision":"' . $rs["genderDivision"] . '",';
	$outp .= '"twitterHandle":"' . $rs["twitterHandle"] . '",';
	$outp .= '"password":"' . $rs["password"] . '",';
	$outp .= '"conference":"' . $rs["conference"] . '"}';
    }
    $outp = '{"TEAMS":['.$outp.']}';
} else {
    $outp = "No results";
}

$conn->close();

echo($outp);
?>
