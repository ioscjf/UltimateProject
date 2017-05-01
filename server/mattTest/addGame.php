<!DOCTYPE html>
<html lang="en">
    <h1>Form entered (game)</h1>

    <?php
//Store entered data in variables for ease
    $teamID = $_POST["teamID"];
    $seasonID = $_POST["seasonID"];
    $date = $_POST["date"];
    $tournament = $_POST["tournament"];
    $gameNum = $_POST["gameNum"];
    $location = $_POST["location"];
    $opponent = $_POST["opponent"];

//    $team = $_POST["team"];

//Show user what they entered
    echo "<p>Here is what you entered:</p>";
    echo "<p Team ID: '$teamID'<br>
           Season ID: '$seasonID'<br>
           Date: '$date'<br>
	   Tournament: '$tournament'<br>
	   gameNum: '$gameNum'<br>
           location: '$location'<br>
	   Opponent: '$opponent'<br></p>";

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

  //  $teamID = "select teamID from team WHERE school = $team";

    //Write to the database 
    $sql = "INSERT INTO games (teamID, date, tournament, gameNum, location, opponent)
        VALUES ('$teamID', '$date', '$tournament', '$gameNum', '$location', '$opponent')";

    //Error handling
    if ($conn->query($sql) === TRUE) {
        echo "<p>Information sccessfully written to the database</p>";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    //Close connection
    $conn->close();
    ?>

  </body>
</html>
