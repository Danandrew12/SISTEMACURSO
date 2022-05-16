<?php 
	
	require '../../modelo/modelo_procedimiento.php';
	$MP = new Modelo_procedimiento();
	$procedimiento = htmlspecialchars($_POST['p'],ENT_QUOTES,'UTF-8');
	$estatus = htmlspecialchars($_POST['e'],ENT_QUOTES,'UTF-8');
	$consulta = $MP->Resgistrar_Procedimiento($procedimiento,$estatus);
		echo ($consulta);
 ?>