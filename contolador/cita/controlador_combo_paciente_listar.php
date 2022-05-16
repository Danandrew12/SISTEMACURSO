<?php 
	require '../../modelo/modelo_cita.php';
	$MC = new Modelo_Cita();
	$consulta = $MC->listar_paciente_combo();
		echo json_encode($consulta); 

?>