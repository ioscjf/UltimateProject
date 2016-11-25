<html>
    <body>
       <h1>Form entered (stats)</h1>

        <?php
    //Store entered data in variables for ease
        $playerName = $_POST["playerName"];
        $position = $_POST["position"];
        $age = $_POST["age"];
        $height = $_POST["height"];
        $school = $_POST["school"];
        $jerseyNum = $_POST["jerseyNum"];

    //Show user what they entered
        echo "<p>Here is what you entered:</p>";
        echo "<p>Name: '$playerName'<br>
                 Position: '$position'<br>
                 Age: '$age'<br>
                 Height: '$height'<br>
                 School: '$school'<br>
                 Jersey number: '$jerseyNum'</p>";

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
        $sql = "INSERT INTO player (playerName, position, age, height, school, jerseyNum)
            VALUES ('$playerName', '$position', '$age', '$height', '$school', '$jerseyNum')";

        //Error handling
        if ($conn->query($sql) === TRUE) {
            echo "<p>Information successfully written to the database.</p>";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }

        //Close connection
        $conn->close();
    ?>

    </body>
</html>
