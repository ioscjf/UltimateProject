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

	<h1>Teams</h1>
	<p>This page is to show all teams that are currently in the teams table of the database</p>
	<p>Note- There is a teamID column as well that is used as a unique identifier for each row, but it increments automatically and we 
		shouldn't need to worry about it at all, so I didn't show it in the table below</p>

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
                echo "<h1>Data</h1><p>The following is the data that currently exists in the teams table";
		$sql = "select * from team";
		$result = $conn->query($sql);
                if ($result->num_rows == 0) {
                        echo "<p>No data</p>";
                } else {
                        echo "<table>";
                        echo "<tr class='header'>
                                <td>School</td>
                                <td>Team name</td>
                                <td>Comp. division</td>
				<td>City</td>
				<td>State</td>
				<td>Conference</td>
				<td>Region</td>
				<td>Gender division</td>
				<td>Twitter handle</td>
			<tr>";
		 	while ($row = $result->fetch_assoc()) {
				echo "<tr><td>" . $row["school"] . "</td>
                        		<td>" . $row["teamName"] . "</td>
					<td>" . $row["competitionDivision"] . "</td>
					<td>" . $row["city"] . "</td>
					<td>" . $row["state"] . "</td>
					<td>" . $row["conference"] . "</td>
					<td>" . $row["region"] . "</td>
                	          	<td>" . $row["genderDivision"] . "</td>
					<td>" . $row["twitterHandle"] . "</td>
				</tr>";
			}
			echo "</table>";
		}
	}
?>

</html>
