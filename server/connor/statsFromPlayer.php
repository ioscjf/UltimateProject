<?php

	$nameFirst = $_POST["nameFirst"];
	$nameLast = $_POST["nameLast"];
	$opponent = $_POST["opponent"]; // there should be more specifiers bu this works for now; will lead to issues when the database is reasonably large or teams are played multiple times
	$teamName = $_POST["teamName"];

	$server = "localhost";
	$user = "admin";
	$password = "frisbee";
	$db = "finalDatabase";
	$conn = new mysqli($server, $user, $password, $db);

	if ($conn->connect_error) {
		throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
	} else {
		$sql3 = "select playerID from player WHERE (nameFirst = '$nameFirst' and nameLast = '$nameLast')";
		$result3 = $conn->query($sql3);

		if (!$result3) {
			throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
		}
		$row3 = mysqli_fetch_assoc($result3);
		$pID = $row3['playerID'];

		$sql0 = "select teamID from team WHERE teamName = '$teamName'";
		$result0 = $conn->query($sql0);

		if (!$result0) {
			throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
		}
		$row0 = mysqli_fetch_assoc($result0);
		$tID = $row0['teamID'];

		$sql2 = "select * from games WHERE (teamID = '$tID' and opponent ='$opponent')";
		$result2 = $conn->query($sql2);

		if (!$result2) {
			throw new Exception("Database Error [{$conn->errno}] {$conn->error}");
		}

		$row2 = mysqli_fetch_assoc($result2);
		$gID = $row2['gameID'];

		$stats = "SELECT * FROM stats WHERE (playerID = '$pID' and gameID = '$gID')";
		$result = $conn->query($stats);

		if ($result->num_rows > 0) {
			// output data of each row

			$outp = "";

			while($rs = $result->fetch_array(MYSQLI_ASSOC)) {
			if ($outp != "") {$outp .= ",";}
			$outp .= '{"scores":"' . $rs["scores"] . '",';
			$outp .= '"assists":"' . $rs["assists"] . '",';
			$outp .= '"completions":"' . $rs["completions"] . '",';
			$outp .= '"throwingErrors":"' . $rs["throwingErrors"] . '",';
			$outp .= '"drops":"' . $rs["drops"] . '",';
			$outp .= '"ds":"' . $rs["ds"] . '",';
			$outp .= '"goallineThrowingErrors":"' . $rs["goallineThrowingErrors"] . '",';
			$outp .= '"goallineDrops":"' . $rs["goallineDrops"] . '",';
			$outp .= '"goallineDs":"' . $rs["goallineDs"] . '",';
			$outp .= '"fouls":"' . $rs["fouls"] . '",';
			$outp .= '"pulls":"' . $rs["pulls"] . '",';
			$outp .= '"pullsOutOfBounds":"' . $rs["pullsOutOfBounds"] . '",';
			$outp .= '"offensivePointsPlayed":"' . $rs["offensivePointsPlayed"] . '",';
			$outp .= '"defensivePointsPlayed":"' . $rs["defensivePointsPlayed"] . '"}';

			}
			$outp = '{"STATS":['.$outp.']}';
			echo($outp);
		} else {
			$outp = '{"STATS":[]}';
			echo($outp);
		}
	}
?>
