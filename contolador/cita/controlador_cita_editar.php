<?php 
	
	require '../../modelo/modelo_cita.php';
	$MC = new Modelo_Cita();
	$idcita = htmlspecialchars($_POST['idcita'],ENT_QUOTES,'UTF-8');
	$idpaciente = htmlspecialchars($_POST['idpa'],ENT_QUOTES,'UTF-8');
	$iddoctor = htmlspecialchars($_POST['iddo'],ENT_QUOTES,'UTF-8');
	$idespecialidad = htmlspecialchars($_POST['idespecialidad'],ENT_QUOTES,'UTF-8');
    $descripcion = htmlspecialchars($_POST['descripcion'],ENT_QUOTES,'UTF-8');
    $estatus = htmlspecialchars($_POST['estatus'],ENT_QUOTES,'UTF-8');
	$consulta = $MC->Editar_Cita($idcita,$idpaciente,$iddoctor,$idespecialidad,$descripcion,$estatus);
		echo $consulta;
		
?>