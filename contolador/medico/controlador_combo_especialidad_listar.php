<?php 
	
	require '../../modelo/modelo_medico.php';
	$MM = new Modelo_Medico();
	$consulta = $MM->listar_especialidad_combo();
		echo json_encode($consulta); 

	?>