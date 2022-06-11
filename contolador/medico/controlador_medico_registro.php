<?php 
	
	require '../../modelo/modelo_medico.php';

	$ME = new Modelo_Medico();
	$nombres = htmlspecialchars($_POST['nombres'],ENT_QUOTES,'UTF-8');
	$apepat = htmlspecialchars($_POST['apepat'], ENT_QUOTES,'UTF-8');
	$apemat = htmlspecialchars($_POST['apemat'],ENT_QUOTES,'UTF-8');
	$direccion = htmlspecialchars($_POST['direccion'],ENT_QUOTES,'UTF-8');
	$movil = htmlspecialchars($_POST['movil'],ENT_QUOTES,'UTF-8');
	$sangre= htmlspecialchars($_POST['sangre'],ENT_QUOTES,'UTF-8');
	$sexo = htmlspecialchars($_POST['sexo'],ENT_QUOTES,'UTF-8');
	$fenac = htmlspecialchars($_POST['fenac'], ENT_QUOTES,'UTF-8');
	$ndoc = htmlspecialchars($_POST['ndoc'],ENT_QUOTES,'UTF-8');
	$ncol = htmlspecialchars($_POST['ncol'],ENT_QUOTES,'UTF-8');
	$especialidad = htmlspecialchars($_POST['especialidad'],ENT_QUOTES,'UTF-8');
	$usuario = htmlspecialchars($_POST['usuario'], ENT_QUOTES,'UTF-8');
	$contra = password_hash($_POST['contra'], PASSWORD_DEFAULT,['cost'=>10]);
	$rol = htmlspecialchars($_POST['rol'],ENT_QUOTES,'UTF-8');
	$email = htmlspecialchars($_POST['email'],ENT_QUOTES,'UTF-8');
	$consulta = $ME->Registrar_Medico($nombres,$apepat,$apemat,$direccion,$movil,$sangre,$sexo,$fenac,$ndoc,$ncol,$especialidad,$usuario,$contra,$rol,$email);
	echo $consulta;
 ?>

 












