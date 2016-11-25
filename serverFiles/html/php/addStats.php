<html>
    <body>
        <h1>Form entered (stats)</h1>

        <?php
    //Store entered data in variables for ease
        $playerName = $_POST["playerName"];
        $year = $_POST["year"];
        $scores = $_POST["scores"];
        $assists = $_POST["assists"];
        $offensivePointsPlayed = $_POST["offensivePointsPlayed"];
        $defensivePointsPlayed = $_POST["defensivePointsPlayed"];
        $drops = $_POST["drops"];
        $catches = $_POST["catches"];
        $completions = $_POST["completions"];

    //Show user what they entered
        echo "<p>Here is what you entered:</p>";
        echo "<p>Player name: '$playerName'<br>
                 Year: '$year'<br>
                 Scores: '$scores'<br>
                 Assists: '$assists'<br>
                 Offensive points played: '$offensivePointsPlayed'<br>
                 Defensive points played: '$defensivePointsPlayed'<br>
                 Drops: '$drops'<br>
                 Catches: '$catches'<br>
                 Completions: '$completions'</p>";

    //Write the data to the database
        $servername = "localhost";
        $username = "admin";
        $password = "frisbee";
        $dbname = "test";

        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        //Write to the database 
        $sql = "INSERT INTO stats (playerName, year, scores, assists, offensivePointsPlayed, defensivePointsPlayed, drops, catches, completions)
            VALUES ('$playerName', '$year', '$scores', '$assists', '$offensivePointsPlayed', '$defensivePointsPlayed',' $drops',' $catches',' $completions')";

        //Error handling
        if ($conn->query($sql) === TRUE) {
            echo "New record created successfully";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }

        //Close connectino
        $conn->close();
    ?>

    </body>
</html>
