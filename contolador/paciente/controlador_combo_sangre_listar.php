<?php 
	
	require '../../modelo/modelo_paciente.php';
	$MP = new Modelo_Paciente();
	$consulta = $MP->listar_sangre_combo();
		echo json_encode($consulta); 

	?>