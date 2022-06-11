<?php 
	
	require '../../modelo/modelo_insumo.php';
	$MI = new Modelo_Insumo();
	$id = htmlspecialchars($_POST['id'],ENT_QUOTES,'UTF-8');
	$insumoactual = htmlspecialchars($_POST['inac'],ENT_QUOTES,'UTF-8');
	$insumonuevo = htmlspecialchars($_POST['innu'],ENT_QUOTES,'UTF-8');
	$stock = htmlspecialchars($_POST['st'],ENT_QUOTES,'UTF-8');
	$fechv = htmlspecialchars($_POST['fe'],ENT_QUOTES,'UTF-8');
	$estatus = htmlspecialchars($_POST['es'],ENT_QUOTES,'UTF-8');
	$consulta = $MI->Modificar_Insumo($id,$insumoactual,$insumonuevo,$stock,$fechv,$estatus);
		echo ($consulta);
 ?>