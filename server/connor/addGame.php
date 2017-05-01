<?php
//Store entered data in variables for ease
    $date = $_POST["date"];
    $tournament = $_POST["tournament"];
    $gameNum = $_POST["gameNum"];
    $location = $_POST["location"];
    $opponent = $_POST["opponent"];

    $team = $_POST["team"];

//Write to the database 
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

    $tID = "select * from team WHERE teamName = '$team'";
    $teamID = $conn->query($tID);
    $seasonID = substr($date, 0, 4);

    $otherrow = mysqli_fetch_assoc($teamID);
    $t = $otherrow['teamID'];

    if (!$teamID) {
        throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
    }

    //Write to the database 
    $sql = "INSERT INTO games (teamID, seasonID, date, tournament, gameNum, location, opponent)
        VALUES ('$t', '$seasonID', '$date', '$tournament', '$gameNum', '$location', '$opponent')";

    //Error handling
    if ($conn->query($sql) === TRUE) {
        echo "<p>Information sccessfully written to the database</p>";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    //Close connection
    $conn->close();
    ?>