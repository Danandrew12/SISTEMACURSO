<?php 
	
	require '../../modelo/modelo_especialidad.php';
	$ME = new Modelo_Especialidad();
	$id = htmlspecialchars($_POST['id'],ENT_QUOTES,'UTF-8');
	$especialidadactual = htmlspecialchars($_POST['espeac'],ENT_QUOTES,'UTF-8');
	$especialidadnueva = htmlspecialchars($_POST['espenu'],ENT_QUOTES,'UTF-8');
	$estatus = htmlspecialchars($_POST['estatus'],ENT_QUOTES,'UTF-8');
	$consulta = $ME->Modificar_Especialidad($id,$especialidadactual,$especialidadnueva,$estatus);
		echo ($consulta);
 ?>