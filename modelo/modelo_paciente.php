<?php 
	class Modelo_Paciente{
		private $conexion;
		function __construct(){
			require_once 'modelo_conexion.php';
			$this->conexion = new conexion();
			$this->conexion->conectar();
		}

		function listar_paciente(){
			$sql = "call SP_LISTAR_PACIENTE()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_sangre_combo(){
			$sql = "call SP_LISTAR_SANGRE_COMBO()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function Registrar_Paciente($nombre,$apepat,$apemat,$direccion,$movil,$sexo,$fcha,$nrodocumento,$sangre){
			$sql = "call SP_REGISTRAR_PACIENTE('$nombre','$apepat','$apemat','$direccion','$movil','$sexo','$fcha','$nrodocumento','$sangre')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				
				$this->conexion->cerrar();
			}
		}

		function Modificar_Paciente($id,$nombres,$apepat,$apemat,$direccion,$movil,$fecha,$sangre,$sexo,$nrodocumentoactual,$nrodocumentonuevo,$estatus){
			$sql = "call SP_MODIFICAR_PACIENTE('$id','$nombres','$apepat','$apemat','$direccion','$movil','$fecha','$sangre','$sexo','$nrodocumentoactual','$nrodocumentonuevo','$estatus')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				
				$this->conexion->cerrar();
			}
		}

	}

?>