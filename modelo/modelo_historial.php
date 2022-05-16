<?php 
	class Modelo_Historial{
		private $conexion;
		function __construct(){
			require_once 'modelo_conexion.php';
			$this->conexion = new conexion();
			$this->conexion->conectar();
		}

		function listar_historial($fechainicio,$fechafin){
			$sql = "call SP_LISTAR_HISTORIAL('$fechainicio','$fechafin')";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)){
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_historial_consulta(){
			$sql = "call SP_LISTAR_CONSULTA_HISTORIAL()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_procedimiento_combo(){
			$sql = "call SP_LISTAR_PROCEDIMIENTO_COMBO()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_insumo_combo(){
			$sql = "call SP_LISTAR_INSUMO_COMBO()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_medicamento_combo(){
			$sql = "call SP_LISTAR_MEDICAMENTO_COMBO()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function TraerStockMedicamento($id){
			$sql = "call SP_TRAER_STOCK_MEDICAMENTO_H('$id')";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function TraerStockInsumo($id){
			$sql = "call SP_TRAER_STOCK_INSUMO_H('$id')";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function Registrar_Fua($idhistorial,$idconsulta){
			$sql = "call SP_REGRISTRAR_FUA('$idhistorial','$idconsulta')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}

				$this->conexion->cerrar();
			}
		}

		function Registrar_Detalle_Procedimiento($id,$arreglo_procedimiento){
			$sql = "call SP_REGRISTRAR_DETALLE_PROCEDIMIENTO('$id','$arreglo_procedimiento')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				return 1;
			}else{
				return 0;
			}
			$this->conexion->cerrar();
		}

		function Registrar_Detalle_Medicamento($id,$arreglo_idmedicamento,$arreglo_cantidad){
			$sql = "call SP_REGRISTRAR_DETALLE_MEDICAMENTO('$id','$arreglo_idmedicamento','$arreglo_cantidad')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				return 1;
			}else{
				return 0;
			}
			$this->conexion->cerrar();
		}

		function Registrar_Detalle_Insumo($id,$arreglo_idinsumo,$arreglo_cantidadinsumo){
			$sql = "call SP_REGRISTRAR_DETALLE_INSUMO('$id','$arreglo_idinsumo','$arreglo_cantidadinsumo')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				return 1;
			}else{
				return 0;
			}
			$this->conexion->cerrar();
		}

		function listar_procedimiento_detalle($id){
			$sql = "call SP_LISTAR_PROCEDIMIENTO_DETALLE('$id')";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_insumo_detalle($id){
			$sql = "call SP_LISTAR_INSUMO_DETALLE('$id')";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_medicamento_detalle($id){
			$sql = "call SP_LISTAR_MEDICAMENTO_DETALLE('$id')";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

}
?>