<?php 
	
	require '../../modelo/modelo_usuario.php';

	$MU = new Modelo_Usuario();
	$idusuario = htmlspecialchars($_POST['idusuario'],ENT_QUOTES,'UTF-8');
	$contrabd = htmlspecialchars($_POST['contrabd'],ENT_QUOTES,'UTF-8');
	$contraactual = htmlspecialchars($_POST['contraactual'],ENT_QUOTES,'UTF-8');
	$contranu = password_hash($_POST['contranu'],PASSWORD_DEFAULT,['cost=>10']);
	if(password_verify($contraactual, $contrabd)){
		$consulta = $MU->Modificar_Contra_Usuario($idusuario,$contranu);
		echo $consulta;
	}else{
		echo 2;
	}
	
 ?>