<!DOCTYPE html>
<html lang="en">
    <h1>My Team</h1>
<?php

//Store entered data in variables for ease
    $teamName = $_POST["teamName"];
    $password = $_POST["password"];

//Show user what they entered
    echo "<p>Here is what you entered:</p>";
    echo "<p>Team name: '$teamName'<br>
             password: '$password'</p>";

    $server = "localhost";
    $user = "admin";
    $pass = "frisbee";
    $db = "finalDatabase";

    $conn = new mysqli($server, $user, $pass, $db);

    if ($conn->connect_error) {
            echo "<h1>Connection error</h1>";
            echo "<p>There was an error in connecting to the database. Please try again</p>";
    } else {
    	$teamID = "SELECT `*` FROM `team` WHERE (`teamName` = '$teamName' and 'password' = '$password')";

    	//$teamID = "select * from team WHERE (teamName = $teamName and password = $password)";

		$result = $conn->query($teamID);
		if (!$result) {
		    throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
		} else {
				$result = $conn->query($teamID);
			 	while ($row = $result->fetch_assoc()) {
	    		echo $row['teamName'];
	    		echo "<br><p>".$row["teamName"]."</p><br>";
			}
	        if ($result->num_rows == 0) {
	            echo "<p>LOGIN FAILED</p>";
	        } else {
	            echo "<p>LOGIN SUCCESS</p>";
			}
		}
	}

    //Close connection
    $conn->close();
?>

</html>
