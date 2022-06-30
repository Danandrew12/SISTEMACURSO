<?php 
	require '../../modelo/modelo_auditoria.php';
	$MA = new Modelo_auditoria();
	$consulta = $MA->listar_auditoria();
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