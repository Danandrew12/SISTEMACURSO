<?php 
	class Modelo_Consulta{
		private $conexion;
		function __construct(){
			require_once 'modelo_conexion.php';
			$this->conexion = new conexion();
			$this->conexion->conectar();
		}

		function listar_consulta($fechainicio,$fechafin){
			$sql = "call SP_LISTAR_CONSULTA('$fechainicio','$fechafin')";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_paciente_combo(){
			$sql = "call SP_LISTAR_PACIENTE_CITA()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function Registrar_Consulta($idpa,$descripcion,$diagnostico){
			$sql = "call SP_REGISTRAR_CONSULTA('$idpa','$descripcion','$diagnostico')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
					return 1;
					
				}else{
					return 0;
				}
				$this->conexion->cerrar();
			}

		function Modificar_Consulta($idconsulta,$descripcion,$diagnostico){
			$sql = "call SP_MODIFICAR_CONSULTA('$idconsulta','$descripcion','$diagnostico')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
					return 1;
					
				}else{
					return 0;
				}
				$this->conexion->cerrar();
			}

		function Modificar_Contra_Usuario($idusuario,$contranu){
			$sql = "call SP_MODIFICAR_CONTRA_USUARIO('$idusuario','$contranu')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				return 1;
				
			}else{
				return 0;
			}
			$this->conexion->cerrar();
		}

		function Modificar_Especialidad($idpaciente,$iddoctor,$descripcion,$idusuario){
			$sql = "call SP_MODIFICAR_ESPECIALIDAD('$idpaciente','$iddoctor','$descripcion','$idusuario')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				$this->conexion->cerrar();
			}
		}

	
}
?>