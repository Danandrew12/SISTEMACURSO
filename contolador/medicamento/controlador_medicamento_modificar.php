<?php 
	
	require '../../modelo/modelo_medicamento.php';
	$MM = new Modelo_Medicamento();
	$id = htmlspecialchars($_POST['id'],ENT_QUOTES,'UTF-8');
	$medicamentoactual = htmlspecialchars($_POST['meac'],ENT_QUOTES,'UTF-8');
	$medicamentonuevo = htmlspecialchars($_POST['menu'],ENT_QUOTES,'UTF-8');
	$alias = htmlspecialchars($_POST['ali'],ENT_QUOTES,'UTF-8');
	$stock = htmlspecialchars($_POST['st'],ENT_QUOTES,'UTF-8');
	$fecha = htmlspecialchars($_POST['fe'],ENT_QUOTES,'UTF-8');
	$estatus = htmlspecialchars($_POST['es'],ENT_QUOTES,'UTF-8');
	$consulta = $MM->Modificar_Medicamento($id,$medicamentoactual,$medicamentonuevo,$alias,$stock,$fecha,$estatus);
		echo ($consulta);
 ?>