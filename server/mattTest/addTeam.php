<!DOCTYPE html>
<html lang="en">
    <!-- /container -->
    <h1>Form entered (team)</h1>

    <?php
//Store entered data in variables for ease
    $school = $_POST["school"];
    $teamName = $_POST["teamName"];
    $competitionDivision = $_POST["competitionDivision"];
    $city = $_POST["city"];
    $state = $_POST["state"];
    $conference = $_POST["conference"];
    $region = $_POST["region"];
    $genderDivision = $_POST["genderDivision"];
    $twitterHandle = $_POST["twitterHandle"];

    $password = $_POST["password"];

//Show user what they entered
    echo "<p>Here is what you entered:</p>";
    echo "<p>School: '$school'<br>
         Team name: '$teamName'<br>
             Competition division: '$competitionDivision'<br>
         City: '$city'<br>
         State: '$state'<br>
             Conference: '$conference'<br>
         Region: '$region'<br>
         Gender division: '$genderDivision'<br>
             Twitter handle: '$twitterHandle'</p>";

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

    //Write to the database 
    $sql = "INSERT INTO team (password, school, teamName, competitionDivision, city, state, conference, region, genderDivision, twitterHandle)
        VALUES ('$password', '$school', '$teamName', '$competitionDivision', '$city', '$state', '$conference', '$region', '$genderDivision', '$twitterHandle')";

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
               
