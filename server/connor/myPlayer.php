<?php

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

        $outp = "";

        $sql3 = "select * from team WHERE (twitterHandle = '$twitterHandle' and teamName = '$teamName')";
        $result3 = $conn->query($sql3);

        if (!$result3) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        }

        $row3 = mysqli_fetch_assoc($result3);
        $tID = $row3['teamID'];

        $sql2 = "select * from playerOnTeam WHERE (teamID = '$tID')";
        $result2 = $conn->query($sql2);

        if (!$result2) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        }

        $arr = array(); // make a new array to hold all your data

        while($row2 = mysqli_fetch_assoc($result2)){ // loop to store the data in an associative array.
             $arr[] = $row2;
        }

        foreach($arr as &$value) {
            $pID = $value['playerID'];
            $sql = "select * from player WHERE (playerID = '$pID')";
            $result = $conn->query($sql);

            if (!$result) {
                throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
            }

            if ($result->num_rows > 0) {
                // output data of each row

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

            }
        }
        $outp = '{"PLAYER":['.$outp.']}';
	}
    echo($outp);
?>