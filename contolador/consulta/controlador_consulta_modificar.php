<?php 
	
	require '../../modelo/modelo_consulta.php';
	$MC = new Modelo_Consulta();
	$idconsulta = htmlspecialchars($_POST['idconsulta'],ENT_QUOTES,'UTF-8');
    $descripcion = htmlspecialchars($_POST['descripcion'],ENT_QUOTES,'UTF-8');
    $diagnostico = htmlspecialchars($_POST['diagnostico'],ENT_QUOTES,'UTF-8');
	$consulta = $MC->Modificar_Consulta($idconsulta,$descripcion,$diagnostico);
		echo ($consulta);
?>