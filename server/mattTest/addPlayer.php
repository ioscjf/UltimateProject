<!DOCTYPE html>
<html lang="en">
    <h1>Form entered (player)</h1>

    <?php
//Store entered data in variables for ease
    $nameFirst = $_POST["nameFirst"];
    $nameLast = $_POST["nameLast"];
    $position = $_POST["position"];
    $birthday = $_POST["birthday"];
    $heightFeet = $_POST["heightFeet"];
    $heightInches = $_POST["heightInches"];
    $height = ($heightFeet * 12) + $heightInches;
    $weight = $_POST["weight"];
    $jerseyNum = $_POST["jerseyNum"];
    $nickname = $_POST["nickname"];

    $teamID = $_POST["team"];

//Show user what they entered
    echo "<p>Here is what you entered:</p>";
    echo "<p>First name: '$nameFirst'<br>
	     Last name: '$nameLast'<br>
         Position: '$position'<br>
	     Birthday: '$birthday'<br>
	     Height: '$height'<br>
         Weight: '$weight'<br>
	     Jersey number: '$jerseyNum'<br>
	     Nickname: '$nickname'<br>
	
	Team: '$teamID'</p>";

//-------------------------------------------

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

    //Write to the database  (player)
    $sql = "INSERT INTO player (nameFirst, nameLast, position, birthday, height, weight, jerseyNum, nickname)
        VALUES ('$nameFirst', '$nameLast', '$position', '$birthday', '$height', '$weight', '$jerseyNum', '$nickname')";

    //Error handling
    if ($conn->query($sql) === TRUE) {
        echo "<p>Successfully added player</p>";
    } else {
        echo "Error writing to players table: " . $sql . "<br>" . $conn->error;
    }

    $year = date("Y");

    echo "<p>Selecting playerID</p>";
    $query = "select* from player WHERE (nameFirst = '$nameFirst' and nameLast = '$nameLast')";
    $result = $conn->query($query);
    if ($result->num_rows == 0) {
	echo "<p>Result variable has no rows</p>";
    } else {
	while ($row = $result->fetch_assoc()) {
	    $playerID = $row["playerID"];
	}

    }
//    $playerIDReal = $playerID["playerID"];
      echo "<p>Player ID is: '$playerID'</p>";

    $sql2 = "INSERT INTO playerOnTeam (playerID, teamID, seasonID)
        VALUES ('$playerID', '$teamID', '$year')";

    if ($conn->query($sql2) === TRUE) {
        echo "<p>Successfully added playerOnTeam</p>";
    } else {
        echo "Error writing to playersOnTeam: " . $sql2 . "<br>" . $conn->error;
    }

    //Close connection
    $conn->close();
    ?>

  </body>
</html>
