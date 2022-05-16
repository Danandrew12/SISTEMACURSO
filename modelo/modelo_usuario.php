<?php 
	class Modelo_Usuario{
		private $conexion;
		function __construct(){
			require_once 'modelo_conexion.php';
			$this->conexion = new conexion();
			$this->conexion->conectar();
		}

		function VerificarUsuario($usuario,$contra){
			$sql = "call SP_VERIFICAR_USUARIO('$usuario')";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					if(password_verify($contra, $consulta_VU["usu_contrasena"]))
					{
						$arreglo[] = $consulta_VU;
					}
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}


		function TraerDatos($usuario){
			$sql = "call SP_VERIFICAR_USUARIO('$usuario')";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_usuario(){
			$sql = "call SP_LISTAR_USUARIO()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_assoc($consulta)) {
					$arreglo["data"][]=$consulta_VU;
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function listar_combo_rol(){
			$sql = "call SP_LISTAR_COMBO_ROL()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
						$arreglo[] = $consulta_VU;
				}
				
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

		function Modificar_Estatus_Usuario($idusuario,$estatus){
			$sql = "call SP_MODIFICAR_ESTATUS_USUARIO('$idusuario','$estatus')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				return 1;
				
			}else{
				return 0;
			}
		}

		function Modificar_Contra_Usuario($idusuario,$contranu){
			$sql = "call SP_MODIFICAR_CONTRA_USUARIO('$idusuario','$contranu')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				return 1;
				
			}else{
				return 0;
			}
		}

		function Modificar_Datos_Usuario($idusuario,$sexo,$rol,$email){
			$sql = "call SP_MODIFICAR_DATOS_USUARIO('$idusuario','$sexo','$rol','$email')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				return 1;
				
			}else{
				return 0;
			}
		}


		function Registrar_Usuario($usuario,$contra,$sexo,$rol,$email){
			$sql = "call SP_REGISTRAR_USUARIO('$usuario','$contra','$sexo','$rol','$email')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				$this->conexion->cerrar();
			}
		}


		function Restablecer_Contra($email,$contra){
			$sql = "call SP_RETABLECER_CONTRA('$email','$contra')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				$this->conexion->cerrar();
			}
		}

		function Modificar_Intento_Usuario($usuario){
			$sql = "call SP_INTENTO_USUARIO('$usuario')";
			if ($consulta = $this->conexion->conexion->query($sql)) {
				if ($row = mysqli_fetch_array($consulta)) {
						return $id= trim($row[0]);
				}
				$this->conexion->cerrar();
			}
		}

		function listar_dashboard(){
			$sql = "call SP_DASHBOARD()";
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[]=$consulta_VU;
				
				}
				return $arreglo;
				$this->conexion->cerrar();
			}
		}

	}
 ?>