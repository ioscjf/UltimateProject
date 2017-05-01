<!DOCTYPE html>
<html lang="en">
    <h1>Form entered (player)</h1>

    <?php
//Store entered data in variables for ease
    $playerID = $_POST["playerID"];
    $gameID = $_POST["gameID"];
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

//Show user what they entered
    echo "<p>Here is what you entered:</p>";
    echo "<p>Player ID: '$playerID'<br>
	Game ID: '$gameID'<br>
	Scores: '$scores'<br>
	Assists: '$assists'<br>
	Completions: '$completions'<br>
	Throwing errors: '$throwingErrors'<br>
	Drops: '$drops'<br>
	Ds: '$ds'<br>
	Goalline throwing errors: '$goallineThrowingErrors'<br>
	Goalline drops: '$goallineDrops'<br>
	Goalline Ds: '$goallineDs'<br>
	Fouls: '$fouls'<br>
	Pulls: '$pulls'<br>
	Pulls out of bounds: '$pullsOutOfBounds'<br>
	Offensive points played: '$offensivePointsPlayed'<br>
	Defensive points played: '$defensivePointsPlayed'</p>";

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

    //$teamID = "select teamID from team WHERE school = $team";

    //Write to the database (gamePlayers)
    $sql = "INSERT INTO gamePlayers (gameID, playerID) VALUES ('$gameID', '$playerID')";
    //Error handling (gamePlayers)
    if ($conn->query($sql) === TRUE) {
        echo "<p>Game players information sccessfully written to the database</p>";
    } else {
        echo "<p>Error when writing game players information</p>";
        echo "Error: " . $sql . "<br>" . $conn->error;
    }    

    //Write to the database (stats)
    $sql = "INSERT INTO stats (playerID, gameID, scores, assists, completions, throwingErrors, drops, ds, goallineThrowingErrors, goallineDrops, goallineDs, fouls, pulls, pullsOutOfBounds, offensivePointsPlayed, defensivePointsPlayed)
        VALUES ('$playerID', '$gameID', '$scores', '$assists', '$completions', '$throwingErrors', '$drops', '$ds', '$goallineThrowingErrors', '$goallineDrops', '$goallineDs', '$fouls', '$pulls', '$pullsOutOfBounds', '$offensivePointsPlayed', '$defensivePointsPlayed')";

    //Error handling (stats)
    if ($conn->query($sql) === TRUE) {
        echo "<p>Stats information sccessfully written to the database</p>";
    } else {
	echo "<p>Error when writing stats information</p>";
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    //Close connection
    $conn->close();
    ?>

  </body>
</html>
