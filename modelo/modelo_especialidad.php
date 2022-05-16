<?php 
	class Modelo_Especialidad{
		private $conexion;
		function __construct(){
			require_once 'modelo_conexion.php';
			$this->conexion = new conexion();
			$this->conexion->conectar();
		}

		function listar_especialidad(){
			$sql = "call SP_LISTAR_ESPECIALIDAD()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function Registrar_Especialidad($especialidad,$estatus){
			$sql = "call SP_REGISTRAR_ESPECIALIDAD('$especialidad','$estatus')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				
				$this->conexion->cerrar();
			}
		}

		function Modificar_Especialidad($id,$especialidadactual,$especialidadnueva,$estatus){
			$sql = "call SP_MODIFICAR_ESPECIALIDAD('$id','$especialidadactual','$especialidadnueva','$estatus')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				
				$this->conexion->cerrar();
			}
		}

	}
?>