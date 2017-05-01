<?php
        $server = "localhost";
        $user = "admin";
        $password = "frisbee";
        $db = "finalDatabase";
        $conn = new mysqli($server, $user, $password, $db);
        if ($conn->connect_error) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        } else {
		$sql = "select * from player";
		$result = $conn->query($sql);
		if (!$result) {
		    throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
		}
        if ($result->num_rows > 0) {
            // output data of each row
            
            $outp = "";

            while($rs = $result->fetch_array(MYSQLI_ASSOC)) {
            if ($outp != "") {$outp .= ",";}
            $outp .= '{"nameFirst":"' . $rs["nameFirst"] . '",';
            $outp .= '"nameLast":"' . $rs["nameLast"] . '",';
            $outp .= '"position":"' . $rs["position"] . '",';
            $outp .= '"birthday":"' . $rs["birthday"] . '",';
            $outp .= '"height":"' . $rs["height"] . '",';
            $outp .= '"weight":"' . $rs["weight"] . '",';
            $outp .= '"jerseyNum":"' . $rs["jerseyNum"] . '",';
            $outp .= '"nickname":"' . $rs["nickname"] . '"}';
            
            }
            $outp = '{"PLAYER":['.$outp.']}';

        } else {
            $outp = '{PLAYER":['.$outp.']}';
		}
	}
    echo($outp);
?>