 <?php
    // Store entered data in variables for ease
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

    $team = $_POST["team"];

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

        //Write to the database 
        $sql = "INSERT INTO player (nameFirst, nameLast, position, birthday, height, weight, jerseyNum, nickname)
            VALUES ('$nameFirst', '$nameLast', '$position', '$birthday', '$height', '$weight', '$jerseyNum', '$nickname')";

        //Error handling
        if ($conn->query($sql) === TRUE) {
            echo "<p>$nameFirst $nameLast successfully added to $team.</p>";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }

        $year = date("Y");
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

        $sql2 = "INSERT INTO playerOnTeam (playerID, teamID, seasonID)
            VALUES ('$p', '$t', '$year')";

        if ($conn->query($sql2) === TRUE) {
            echo "<p>Successfully added playerOnTeam</p>";
        } else {
            echo "Error: " . $sql2 . "<br>" . $conn->error;
        }

        //Close connection
        $conn->close();
    ?>
