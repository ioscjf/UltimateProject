<?php

//Store entered data in variables for ease
    $teamName = $_POST["teamName"];
    $twitterHandle = $_POST["twitterHandle"];

        $server = "localhost";
        $user = "admin";
        $password = "frisbee";
        $db = "finalDatabase";
        $conn = new mysqli($server, $user, $password, $db);
        if ($conn->connect_error) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        } else {
		$sql = "select * from team WHERE (twitterHandle = '$twitterHandle' and teamName = '$teamName')";
		$result = $conn->query($sql);

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
            $outp = '{"MYTEAM":['.$outp.']}';

        } else {
            $outp = '{MYTEAM":['.$outp.']}';
		}
	}
    echo($outp);
?>