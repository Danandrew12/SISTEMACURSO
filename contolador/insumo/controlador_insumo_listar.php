<?php 
	
	require '../../modelo/modelo_insumo.php';
	$MI = new Modelo_Insumo();
	$consulta = $MI->listar_insumo();
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