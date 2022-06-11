<?php 
	
	require '../../modelo/modelo_insumo.php';
	$MI = new Modelo_Insumo();
	$insumo = htmlspecialchars($_POST['in'],ENT_QUOTES,'UTF-8');
	$stock = htmlspecialchars($_POST['st'],ENT_QUOTES,'UTF-8');
	$fechv = htmlspecialchars($_POST['fe'],ENT_QUOTES,'UTF-8');
	$estatus = htmlspecialchars($_POST['es'],ENT_QUOTES,'UTF-8');
	$consulta = $MI->Registrar_Insumo($insumo,$stock,$fechv,$estatus);
		echo ($consulta);
 ?>