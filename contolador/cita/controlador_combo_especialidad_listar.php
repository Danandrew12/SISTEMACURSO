<?php 
	require '../../modelo/modelo_cita.php';
	$MC = new Modelo_Cita();
	$consulta = $MC->listar_especialidad_combo();
		echo json_encode($consulta); 

	?>