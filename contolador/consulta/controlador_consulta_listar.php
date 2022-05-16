<?php 
	require '../../modelo/modelo_consulta.php';
	$MC = new Modelo_Consulta();
	$fechainicio = htmlspecialchars($_POST['fechainicio'],ENT_QUOTES,'UTF-8');
	$fechafin = htmlspecialchars($_POST['fechafin'],ENT_QUOTES,'UTF-8');
	$consulta = $MC->listar_consulta($fechainicio,$fechafin);
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