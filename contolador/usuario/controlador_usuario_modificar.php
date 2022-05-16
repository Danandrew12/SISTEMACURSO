<?php 
	
	require '../../modelo/modelo_usuario.php';

	$MU = new Modelo_Usuario();
	$idusuario = htmlspecialchars($_POST['idusuario'],ENT_QUOTES,'UTF-8');
	$sexo = htmlspecialchars($_POST['sexo'],ENT_QUOTES,'UTF-8');
	$rol = htmlspecialchars($_POST['rol'],ENT_QUOTES,'UTF-8');
	$email = htmlspecialchars($_POST['email'],ENT_QUOTES,'UTF-8');
	$consulta = $MU->Modificar_Datos_Usuario($idusuario,$sexo,$rol,$email);
	echo $consulta;
 ?>