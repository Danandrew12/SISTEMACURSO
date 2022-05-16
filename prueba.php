<?php 
	$pass= password_hash('ANDrew',PASSWORD_DEFAULT,['cost=>12']);
	echo $pass;
 ?>