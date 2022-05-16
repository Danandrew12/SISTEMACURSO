<?php 
	require '../../modelo/modelo_historial.php';
	$MH = new Modelo_Historial();
	$id= htmlspecialchars($_POST['id'],ENT_QUOTES,'UTF-8');
	$consulta = $MH->TraerStockInsumo($id);
		echo json_encode($consulta); 

?>