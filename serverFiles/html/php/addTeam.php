<html>
    <body>
        <h1>Form entered (team)</h1>

        <?php
    //Store entered data in variables for ease
        $teamName = $_POST["teamName"];
        $school = $_POST["school"];
        $competitionDivision = $_POST["competitionDivision"];
        $year = $_POST["year"];
        $region = $_POST["region"];
        $conference = $_POST["conference"];

    //Show user what they entered
        echo "<p>Here is what you entered:</p>";
        echo "<p>Team name: '$teamName'<br>
                 School: '$school'<br>
                 Competition division: '$competitionDivision'<br>
                 Year: '$year'<br>
                 Region: '$region'<br>
                 Conference: '$conferense'</p>";

    //Write to the database 
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
        $sql = "INSERT INTO team (teamName, school, competitionDivision, year, region, conference)
            VALUES ('$teamName', '$school', '$competitionDivision', '$year', '$region', '$conference')";

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
