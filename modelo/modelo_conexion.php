<?php 
	class conexion{
		private $servidor;
		private $usuario;
		private $contraseña;
		private $basedatos;
		public $conexion;
		public function __construct(){
			$this->servidor = "localhost";
			$this->usuario = "root";
			$this->contraseña = "";
			$this->basedatos = "bd_curso";
		}
		function conectar(){
			$this->conexion = new mysqli($this->servidor,$this->usuario,$this->contraseña,$this->basedatos);
			$this->conexion->set_charset("utf8");
		}
		function cerrar(){
			$this->conexion->close();
		}
	}
 ?>