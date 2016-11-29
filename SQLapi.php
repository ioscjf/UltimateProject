<?php
// Connecting, selecting database
$link = mysql_connect('127.0.0.1/test', 'admin', 'frisbee')
    or die('Could not connect: ' . mysql_error());
echo 'Connected successfully';
mysql_select_db('my_database') or die('Could not select database');

// Performing SQL query
$query = 'SELECT * FROM my_table';
$result = mysql_query($query) or die('Query failed: ' . mysql_error());

//Print results in HTML if there are results
if (mysql_num_rows($result) > 0) {
    echo "<table>\n";
    while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
        echo "\t<tr>\n";
        foreach ($line as $col_value) {
            echo "\t\t<td>$col_value</td>\n";
        }
        echo "\t</tr>\n";
    }
    echo "</table>\n";
}

// Free resultset
mysql_free_result($result);

// Closing connection
mysql_close($link);
?>