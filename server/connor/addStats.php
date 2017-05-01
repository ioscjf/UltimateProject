<?php
    //Store entered data in variables for ease

    $nameFirst = $_POST["nameFirst"];
    $nameLast = $_POST["nameLast"];
    $opponent = $_POST["opponent"];
    $team = $_POST["teamName"];

    $scores = $_POST["scores"];
    $assists = $_POST["assists"];
    $completions = $_POST["completions"];
    $throwingErrors = $_POST["throwingErrors"];
    $drops = $_POST["drops"];
    $ds = $_POST["ds"];
    $goallineThrowingErrors = $_POST["goallineThrowingErrors"];
    $goallineDrops = $_POST["goallineDrops"];
    $goallineDs = $_POST["goallineDs"];
    $fouls = $_POST["fouls"];
    $pulls = $_POST["pulls"];
    $pullsOutOfBounds = $_POST["pullsOutOfBounds"];
    $offensivePointsPlayed = $_POST["offensivePointsPlayed"];
    $defensivePointsPlayed = $_POST["defensivePointsPlayed"];

    //Write the data to the database
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

        $tID = "select teamID from team WHERE teamName = '$team'";
        $pID = "select playerID from player WHERE (nameFirst = '$nameFirst' and nameLast = '$nameLast')";

        $playerID = $conn->query($pID);
        $teamID = $conn->query($tID);

        $row = mysqli_fetch_assoc($playerID);
        $otherrow = mysqli_fetch_assoc($teamID);
        $p = $row['playerID'];
        $t = $otherrow['teamID'];

        if (!$teamID) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        }
        if (!$playerID) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        }

        $gID = "select gameID from games WHERE (teamID = '$t' and opponent = '$opponent')";
        $gameID = $conn->query($gID);
        $grow = mysqli_fetch_assoc($gameID);
        $g = $grow['gameID'];

        if (!$gameID) {
            throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
        }

        //Write to the database 
        $sql = "INSERT INTO stats (playerID, gameID, scores, assists, completions, throwingErrors, drops, ds, goallineThrowingErrors, goallineDrops, goallineDs, fouls, pulls, pullsOutOfBounds, offensivePointsPlayed, defensivePointsPlayed)
            VALUES ('$p', '$g', '$scores', '$assists', '$completions', '$throwingErrors', '$drops', '$ds', '$goallineThrowingErrors', '$goallineDrops', '$goallineDs', '$fouls', '$pulls', '$pullsOutOfBounds', '$offensivePointsPlayed', '$defensivePointsPlayed')";

        //Error handling
        if ($conn->query($sql) === TRUE) {
            echo "'$nameFirst' '$nameLast' has added new stats";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }

        $sql2 = "INSERT INTO gamePlayers (playerID, gameID)
            VALUES ('$p', '$g')";

        //Error handling
        if ($conn->query($sql2) === TRUE) {
            echo "'$nameFirst' '$nameLast' has played in '$g'";
        } else {
            echo "Error: " . $sql2 . "<br>" . $conn->error;
        }

        //Close connection
        $conn->close();
    ?>
