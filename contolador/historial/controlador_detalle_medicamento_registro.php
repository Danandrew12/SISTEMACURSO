<?php 
	require '../../modelo/modelo_historial.php';
	$MH = new Modelo_Historial();
	$id= htmlspecialchars($_POST['id'],ENT_QUOTES,'UTF-8');
	$idmedicamento= htmlspecialchars($_POST['idmedicamento'],ENT_QUOTES,'UTF-8');
	$cantidad= htmlspecialchars($_POST['cantidad'],ENT_QUOTES,'UTF-8');
	$arreglo_idmedicamento = explode(",",$idmedicamento);//Separo mis datos
	$arreglo_cantidad = explode(",",$cantidad);//Separo mis datos
	for ($i=0;$i<count($arreglo_idmedicamento);$i++){
		$consulta = $MH->Registrar_Detalle_Medicamento($id,$arreglo_idmedicamento[$i],$arreglo_cantidad[$i]);
	}
	
		echo($consulta); 

?>