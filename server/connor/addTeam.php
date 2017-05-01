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

//Write to the database 
    $servername = "localhost";
    $username = "admin";
    $pass = "frisbee";
    $dbname = "finalDatabase";

    // Create connection
    $conn = new mysqli($servername, $username, $pass, $dbname);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    //Write to the database 
    $sql = "INSERT INTO team (school, teamName, competitionDivision, city, state, conference, region, genderDivision, twitterHandle, password)
        VALUES ('$school', '$teamName', '$competitionDivision', '$city', '$state', '$conference', '$region', '$genderDivision', '$twitterHandle', '$password')";
    //Error handling
    if ($conn->query($sql) === TRUE) {
        echo "<p>$school has been added to the database.</p>";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    //Close connection
    $conn->close();
    ?>     