<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Add New Player</title>

    <!-- Bootstrap core CSS -->
    <link href="../../dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="addInfo.css" rel="stylesheet">
    <link href="stylesheet.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

   <body style="background-color: #525252">
      <div class="navbar-wrapper">
        <div class="nav-container">
          <nav class="navbar navbar-inverse navbar-static-top">
            <div class="nav-container">
              <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Ultimate Statistics</a>
              </div>
              <div id="header-navbar" class="navbar-collapse collapse">
                <ul class="header-nav navbar-nav">
                  <li><a href="index.html">Home</a></li>
                  <li><a href="#about">About</a></li>
                  <li><a href="#contact">Contact</a></li>
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Teams <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li><a href="website/bootstrap-3.3.7/docs/examples/carousel/mens-players.html">Men's</a></li>
                      <li><a href="womens.html">Women's</a></li>
                      <li><a href="mixed.html">Mixed</a></li>
                      <li role="separator" class="divider"></li>
                      <li class="dropdown-header">Nav header</li>
                      <li><a href="#">Separated link</a></li>
                      <li><a href="#">One more separated link</a></li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
        </div>
      </div>

    <br>
    <br>
    <br>    
    <!-- /container -->
    <h1>Form entered (team)</h1>

    <?php
//Store entered data in variables for ease
    $teamName = $_POST["teamName"];
    $school = $_POST["school"];
    $competitionDivision = $_POST["competitionDivision"];
    $year = $_POST["year"];
    $state = $_POST["state"];
    $region = $_POST["region"];
    $conference = $_POST["conference"];

//Show user what they entered
    echo "<p>Here is what you entered:</p>";
    echo "<p>Team name: '$teamName'<br>
             School: '$school'<br>
             Competition division: '$competitionDivision'<br>
             Year: '$year'<br>
	     State: '$state'<br>
             Region: '$region'<br>
             Conference: '$conference'</p>";

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
    $sql = "INSERT INTO team (teamName, school, competitionDivision, year, state, region, conference)
        VALUES ('$teamName', '$school', '$competitionDivision', '$year', '$state', '$region', '$conference')";

    //Error handling
    if ($conn->query($sql) === TRUE) {
        echo "<p>Information sccessfully written to the database</p>";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    //Close connection
    $conn->close();
    ?>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="../../dist/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="../../assets/js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
               
