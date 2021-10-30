<html>
  <head><title>Welcome to my excellent blog</title></head>
    <body>
      <h1>Welcome to my excellent blog</h1>
      <?php  
      $serverName = "CLOUDSQLIP";
        $uid = "blogdbuser";
        $pwd = "DBPASSWORD";  
        $connectionInfo = array( "UID"=>$uid, "PWD"=>$pwd, "Database"=>"tempdb");  
      $conn = sqlsrv_connect( $serverName, $connectionInfo);  
      if( $conn ){  
            echo "Connection established.\n";  
      }  
      else{  
      echo "Connection could not be established.\n";
        die( print_r( sqlsrv_errors(), true));  
      }  
      sqlsrv_close( $conn);  
      ?>
    </body> 
</html>