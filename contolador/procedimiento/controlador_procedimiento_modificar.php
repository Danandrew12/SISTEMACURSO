<?php 
	
	require '../../modelo/modelo_procedimiento.php';
	$MP = new Modelo_procedimiento();
	$id = htmlspecialchars($_POST['id'],ENT_QUOTES,'UTF-8');
	$procedimientoactual = htmlspecialchars($_POST['procedimientoactual'],ENT_QUOTES,'UTF-8');
	$procedimientonuevo = htmlspecialchars($_POST['procedimientonuevo'],ENT_QUOTES,'UTF-8');
	$estatus = htmlspecialchars($_POST['estatus'],ENT_QUOTES,'UTF-8');
	$consulta = $MP->Modificar_Procedimiento($id,$procedimientoactual,$procedimientonuevo,$estatus);
		echo ($consulta);
		
 ?>