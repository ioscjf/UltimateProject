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

        $sql2 = "select * from games WHERE (teamID = '$tID')";
        $result = $conn->query($sql2);

        if (!$result) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        }

        $arr = array(); // make a new array to hold all your data

        while($row2 = mysqli_fetch_assoc($result)){ // loop to store the data in an associative array.
             $arr[] = $row2;
        }

        foreach($arr as &$rs) {
            if ($outp != "") {$outp .= ",";}
            $outp .= '{"date":"' . $rs["date"] . '",';
            $outp .= '"tournament":"' . $rs["tournament"] . '",';
            $outp .= '"gameNum":"' . $rs["gameNum"] . '",';
            $outp .= '"location":"' . $rs["location"] . '",';
            $outp .= '"opponent":"' . $rs["opponent"] . '"}';
        }
        $outp = '{"GAME":['.$outp.']}';
	}
    echo($outp);
?>




























