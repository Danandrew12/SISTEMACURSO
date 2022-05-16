<?php 
	require '../../modelo/modelo_consulta.php';
	$MC = new Modelo_Consulta();
	$consulta = $MC->listar_paciente_combo();
	echo json_encode($consulta); 

?>