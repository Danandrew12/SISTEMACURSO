<?php 
	
	require '../../modelo/modelo_usuario.php';

	$MU = new Modelo_Usuario();
	$usuario = htmlspecialchars($_POST['usuario'],ENT_QUOTES,'UTF-8');
	$contra = password_hash($_POST['contrasena'], PASSWORD_DEFAULT,['cost'=>10]);
	$sexo = htmlspecialchars($_POST['sexo'],ENT_QUOTES,'UTF-8');
	$rol = htmlspecialchars($_POST['rol'],ENT_QUOTES,'UTF-8');
	$email = htmlspecialchars($_POST['email'],ENT_QUOTES,'UTF-8');
	$consulta = $MU->Registrar_Usuario($usuario,$contra,$sexo,$rol,$email);
	echo $consulta;
 ?>