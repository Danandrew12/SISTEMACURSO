<?php 
	
	require '../../modelo/modelo_paciente.php';
	$MP = new Modelo_Paciente();
	$nombres = htmlspecialchars($_POST['nombres'],ENT_QUOTES,'UTF-8');
	$apepat = htmlspecialchars($_POST['apepat'],ENT_QUOTES,'UTF-8');
	$apemat = htmlspecialchars($_POST['apemat'],ENT_QUOTES,'UTF-8');
	$direccion = htmlspecialchars($_POST['direccion'],ENT_QUOTES,'UTF-8');
	$movil = htmlspecialchars($_POST['movil'],ENT_QUOTES,'UTF-8');
	$sexo = htmlspecialchars($_POST['sexo'],ENT_QUOTES,'UTF-8');
	$fcha = htmlspecialchars($_POST['fcha'],ENT_QUOTES,'UTF-8');
	$nrodocumento = htmlspecialchars($_POST['nrodocumento'],ENT_QUOTES,'UTF-8');
	$sangre = htmlspecialchars($_POST['sangre'],ENT_QUOTES,'UTF-8');
	$consulta = $MP->Registrar_Paciente($nombres,$apepat,$apemat,$direccion,$movil,$sexo,$fcha,$nrodocumento,$sangre);
		echo ($consulta);
 ?>