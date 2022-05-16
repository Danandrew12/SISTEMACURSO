<?php 
	
	require '../../modelo/modelo_especialidad.php';
	$ME = new Modelo_Especialidad();
	$especialidad = htmlspecialchars($_POST['especialidad'],ENT_QUOTES,'UTF-8');
	$estatus = htmlspecialchars($_POST['estatus'],ENT_QUOTES,'UTF-8');
	$consulta = $ME->Registrar_Especialidad($especialidad,$estatus);
		echo ($consulta);
 ?>