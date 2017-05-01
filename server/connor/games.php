<?php
        $server = "localhost";
        $user = "admin";
        $password = "frisbee";
        $db = "finalDatabase";
        $conn = new mysqli($server, $user, $password, $db);
        if ($conn->connect_error) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        } else {
		$sql = "select * from games";
		$result = $conn->query($sql);


		if (!$result) {
		    throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
		}
        if ($result->num_rows > 0) {
            // output data of each row
            
            $outp = "";

            while($rs = $result->fetch_array(MYSQLI_ASSOC)) {
            	if ($outp != "") {$outp .= ",";}
            		$outp .= '{"date":"' . $rs["date"] . '",';
            		$outp .= '"tournament":"' . $rs["tournament"] . '",';
            		$outp .= '"gameNum":"' . $rs["gameNum"] . '",';
            		$outp .= '"location":"' . $rs["location"] . '",';
            		$outp .= '"opponent":"' . $rs["opponent"] . '"}';
            }
            $outp = '{"GAMES":['.$outp.']}';
        } else {
            $outp = '{GAMES":['.$outp.']}';
		}
	}
    echo($outp);
?>