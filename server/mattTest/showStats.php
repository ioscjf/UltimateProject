<html>
	<style>
		table, tr, td {
			border: 1px solid black;
			border-collapse: collapse;
		}
		tr.header {
			background-color: #888;
		}
		td {
			padding-top: 3px;
			padding-bottom: 3px;
			padding-left: 5px;
			padding-right: 10px;
		}
	</style>

	<h1>Stats</h1>
	<p>This page is to show all players that are currently in the stats table of the database</p>

<?php
        $server = "localhost";
        $user = "admin";
        $password = "frisbee";
        $db = "finalDatabase";
        $conn = new mysqli($server, $user, $password, $db);
        if ($conn->connect_error) {
                echo "<h1>Connection error</h1>";
                echo "<p>There was an error in connecting to the database. Please try again</p>";
        } else {
                echo "<h1>Data</h1><p>The following is the data that currently exists in the stats table:</p>";
		$sql = "select * from stats";
		$result = $conn->query($sql);
                if ($result->num_rows == 0) {
                        echo "<p>No data</p>";
                } else {
                        echo "<table>";
                        echo "<tr class='header'>
				<td>Player ID</td>
                                <td>Game ID</td>
                                <td>Scores</td>
                                <td>Assists</td>
				<td>Completions</td>
				<td>Drops</td>
				<td>Ds</td>
				<td>GL. Thrw. Err.</td>
				<td>GL. Drops</td>
				<td>GL. Ds</td>
				<td>Fouls</td>
				<td>Pulls</td>
				<td>Pulls O.B.</td>
				<td>O Pts. Played</td>
				<td>D Pts. Played</td>
				<tr>";
		 	while ($row = $result->fetch_assoc()) {
				echo "<tr><td>" . $row["playerID"] . "</td>
                    		<td>" . $row["gameID"] . "</td>
				<td>" . $row["scores"] . "</td>
				<td>" . $row["assists"] . "</td>
				<td>" . $row["completions"] . "</td>
				<td>" . $row["drops"] . "</td>
				<td>" . $row["ds"] . "</td>
				<td>" . $row["goallineThrowingErrors"] . "</td>
				<td>" . $row["goallineDrops"] . "</td>
				<td>" . $row["goallineDs"] . "</td>
				<td>" . $row["fouls"] . "</td>
				<td>" . $row["pulls"] . "</td>
				<td>" . $row["pullsOutOfBounds"] . "</td>
				<td>" . $row["offensivePointsPlayed"] . "</td>
                		<td>" . $row["defensivePointsPlayed"] . "</td></tr>";
			}
			echo "</table>";
		}
	}
?>

</html>
