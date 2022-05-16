<?php 
	require '../../modelo/modelo_historial.php';
	$MH = new Modelo_Historial();
	$id= htmlspecialchars($_POST['id'],ENT_QUOTES,'UTF-8');
	$idinsumo= htmlspecialchars($_POST['idinsumo'],ENT_QUOTES,'UTF-8');
	$cantidadinsumo= htmlspecialchars($_POST['cantidadinsumo'],ENT_QUOTES,'UTF-8');
	$arreglo_idinsumo = explode(",",$idinsumo);//Separo mis datos
	$arreglo_cantidadinsumo = explode(",",$cantidadinsumo);//Separo mis datos
	for ($i=0;$i<count($arreglo_idinsumo);$i++){
		$consulta = $MH->Registrar_Detalle_Insumo($id,$arreglo_idinsumo[$i],$arreglo_cantidadinsumo[$i]);
	}
	
		echo($consulta); 

?>