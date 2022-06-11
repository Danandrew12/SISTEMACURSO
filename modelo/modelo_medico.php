<?php 
	class Modelo_Medico{
		private $conexion;
		function __construct(){
			require_once 'modelo_conexion.php';
			$this->conexion = new conexion();
			$this->conexion->conectar();
		}

		function listar_medico(){
			$sql = "call SP_LISTAR_MEDICO()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_especialidad_combo(){
			$sql = "call SP_LISTAR_COMBO_ESPECIALIDAD()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				
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

		function Registrar_Medico($nombres,$apepat,$apemat,$direccion,$movil,$sangre,$sexo,$fenac,$ndoc,$ncol,$especialidad,$usuario,$contra,$rol,$email){
			$sql = "call SP_REGISTRAR_MEDICO('$nombres','$apepat','$apemat','$direccion','$movil','$sangre','$sexo','$fenac','$ndoc','$ncol','$especialidad','$usuario','$contra','$rol','$email')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				
				$this->conexion->cerrar();
			}
		}

		function Modifiar_Medico($idmedico,$nombres,$apepat,$apemat,$direccion,$movil,$sexo,$fenac,$sangre,$ndocactual,$ndocnuevo,$ncolactual,$ncolnuevo,$especialidad,$idusuario,$email){
			$sql = "call SP_MODIFICAR_MEDICO('$idmedico','$nombres','$apepat','$apemat','$direccion','$movil','$sexo','$fenac','$sangre','$ndocactual','$ndocnuevo','$ncolactual','$ncolnuevo','$especialidad','$idusuario','$email')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}

				$this->conexion->cerrar();
			}
		}

		function Modificar_Procedimiento($id,$procedimientoactual,$procedimientonuevo,$estatus){
			$sql = "call SP_MODIFICAR_PROCEDIMIENTO('$id','$procedimientoactual','$procedimientonuevo','$estatus')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				
				$this->conexion->cerrar();
			}
		}

	}
?>