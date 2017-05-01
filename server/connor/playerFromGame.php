<?php

    $teamName = $_POST["teamName"];
    $twitterHandle = $_POST["twitterHandle"];
    $opponent = $_POST["opponent"];

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

        $sql2 = "select * from games WHERE (teamID = '$tID' and opponent = '$opponent')";
        $result2 = $conn->query($sql2);

        if (!$result2) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        }

        $row2 = mysqli_fetch_assoc($result2);
        $gID = $row2['gameID'];


        $sql1 = "select gameID, playerID from gamePlayers WHERE gameID = '$gID'";
        $result1 = $conn->query($sql1);

        $arr = array(); // make a new array to hold all your data

        while($row1 = mysqli_fetch_assoc($result1)){ // loop to store the data in an associative array.
             $arr[] = $row1;
        }

        $arr = array_map("unserialize", array_unique(array_map("serialize", $arr)));

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