<?php 
	require '../../modelo/modelo_historial.php';
	$MH = new Modelo_Historial();
	$consulta = $MH->listar_medicamento_combo();
		echo json_encode($consulta); 

?>