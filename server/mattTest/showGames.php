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

	<h1>Games</h1>
	<p>This page is to show all players that are currently in the games table of the database</p>

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
                echo "<h1>Data</h1><p>The following is the data that currently exists in the players table:</p>";
		$sql = "select * from games";
		$result = $conn->query($sql);
                if ($result->num_rows == 0) {
                        echo "<p>No data</p>";
                } else {
                        echo "<table>";
                        echo "<tr class='header'>
                                <td>Game ID</td>
                                <td>Team ID</td>
                                <td>Season ID</td>
								<td>Date</td>
								<td>Tournament</td>
								<td>Game #</td>
								<td>Location</td>
								<td>Opponent</td>
								<tr>";
		 	while ($row = $result->fetch_assoc()) {
				echo "<tr><td>" . $row["gameID"] . "</td>
                    <td>" . $row["teamID"] . "</td>
					<td>" . $row["seasonID"] . "</td>
					<td>" . $row["date"] . "</td>
					<td>" . $row["tournament"] . "</td>
					<td>" . $row["gameNum"] . "</td>
					<td>" . $row["location"] . "</td>
                	<td>" . $row["opponent"] . "</td></tr>";
			}
			echo "</table>";
		}
	}
?>

</html>