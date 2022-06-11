<?php 
	class Modelo_Medicamento{
		private $conexion;
		function __construct(){
			require_once 'modelo_conexion.php';
			$this->conexion = new conexion();
			$this->conexion->conectar();
		}

		function listar_medicamento(){
			$sql = "call SP_LISTAR_MEDICAMENTO()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function Registrar_Medicamento($medicamento,$alias,$stock,$fecha,$estatus){
			$sql = "call SP_REGISTRAR_MEDICAMENTO('$medicamento','$alias','$stock','$fecha','$estatus')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				
				$this->conexion->cerrar();
			}
		}

		function Modificar_Medicamento($id,$medicamentoactual,$medicamentonuevo,$alias,$stock,$fecha,$estatus){
			$sql = "call SP_MODIFICAR_MEDICAMENTO('$id','$medicamentoactual','$medicamentonuevo','$alias','$stock','$fecha','$estatus')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				
				$this->conexion->cerrar();
			}
		}

	}
?>