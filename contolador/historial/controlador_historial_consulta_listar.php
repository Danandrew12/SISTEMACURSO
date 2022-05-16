<?php 	
	require '../../modelo/modelo_historial.php';
	$MH = new Modelo_Historial();
    $consulta = $MH->listar_historial_consulta();
	if ($consulta) {
		echo json_encode($consulta);
	}else {
		echo '{
			"sEcho": 1,
			"iTotalRecords": "0",
			"iTotalDisplayRecords": "0",
			"aaData": []
		}';
	}
?>