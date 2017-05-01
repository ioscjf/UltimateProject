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

	<h1>Players</h1>
	<p>This page is to show all players that are currently in the players table of the database</p>

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
		$sql = "select * from player";
		$result = $conn->query($sql);
                if ($result->num_rows == 0) {
                        echo "<p>No data</p>";
                } else {
                        echo "<table>";
                        echo "<tr class='header'>
                                <td>Player ID</td>
                                <td>First name</td>
                                <td>Last name</td>
								<td>Position</td>
								<td>Birthday</td>
								<td>Height</td>
								<td>Weight</td>
								<td>Jersey number</td>
								<td>Nickname</td>
								<tr>";
		 	while ($row = $result->fetch_assoc()) {
				echo "<tr><td>" . $row["playerID"] . "</td>
                    <td>" . $row["nameFirst"] . "</td>
					<td>" . $row["nameLast"] . "</td>
					<td>" . $row["position"] . "</td>
					<td>" . $row["birthday"] . "</td>
					<td>" . $row["height"] . "</td>
					<td>" . $row["weight"] . "</td>
                	<td>" . $row["jerseyNum"] . "</td>
                	<td>" . $row["nickname"] . "</td></tr>";
			}
			echo "</table>";
		}
	}
?>

</html>