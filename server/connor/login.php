<?php

//Store entered data in variables for ease
    $teamName = $_POST["teamName"];
    $password = $_POST["password"];

    $server = "localhost";
    $user = "admin";
    $pass = "frisbee";
    $db = "finalDatabase";

    $conn = new mysqli($server, $user, $pass, $db);

    if ($conn->connect_error) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
    } else {
    	$teamID = "SELECT `*` FROM `team` WHERE (`teamName` = '$teamName' and 'password' = '$password')";

    	//$teamID = "select * from team WHERE (teamName = $teamName and password = $password)";

		$result = $conn->query($teamID);
		if (!$result) {
		    throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
		}
        if ($result->num_rows > 0) {
            // output data of each row
            
            $outp = "";

            while($rs = $result->fetch_array(MYSQLI_ASSOC)) {
            if ($outp != "") {$outp .= ",";}
            $outp .= '{"School":"' . $rs["school"] . '",';
            $outp .= '"teamName":"' . $rs["teamName"] . '",';
            $outp .= '"competitionDivision":"' . $rs["competitionDivision"] . '",';
            $outp .= '"city":"' . $rs["city"] . '",';
            $outp .= '"state":"' . $rs["state"] . '",';
            $outp .= '"conference":"' . $rs["conference"] . '",';
            $outp .= '"region":"' . $rs["region"] . '",';
            $outp .= '"genderDivision":"' . $rs["genderDivision"] . '",';
            $outp .= '"twitterHandle":"' . $rs["twitterHandle"] . '"}';
            
            }
            $outp = '{"LOGIN":['.$outp.']}';

        } else {
            $outp = '{"LOGIN":['.$outp.']}';
		}
	}

    //Close connection
    $conn->close();
    echo($outp);
?>
