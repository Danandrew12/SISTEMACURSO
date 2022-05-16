<?php

require_once __DIR__ . '/../vendor/autoload.php';
require_once '../../conexion_reporte/r_conexion.php';
$consulta = "SELECT cita.cita_id, cita.cita_nroatencion, cita.cita_feregistro, CONCAT_WS(' ', medico.medico_nombre, medico.medico_apepart, medico.medico_apemart) as medico, CONCAT_WS(' ', paciente.paciente_nombre, paciente.paciente_apepat, paciente.paciente_apemat) as paciente, cita.cita_descripcion, especialidad.especialidad_nombre
FROM cita INNER JOIN medico ON cita.medico_id = medico.medico_id INNER JOIN paciente ON cita.paciente_id = paciente.paciente_id INNER JOIN especialidad ON medico.especialidad_id =  especialidad.especialidad_id WHERE cita_id='".$_GET['id']."'";
$html=" 
<table style='border-collapse:collapse' border='1'>
		<tr>
			<td style='border-bottom:1px solid;border-left:0px;border-right:0px;border-top:0px;'><h2 style='font-size:18px;'>Datos De La Cita</h2></td>
		</tr>
			
</table>";
$resultado=$mysqli->query($consulta);
while($row=$resultado->fetch_assoc()){
	$html.="<style>
.barcode {
    padding: 1.5mm;
    margin: 0;
    vertical-align: top;
    color: black;
}
.barcodecell {
    text-align: center;
    vertical-align: middle;
}
</style>
	<b>N&uacute;mero atenci&oacute;n:</b>".$row['cita_nroatencion']."
	<br><b>Paciente:</b><br>".$row['paciente']."<br>
	<b>Medico:</b><br>".$row['medico']."<br>
	<b>Especialidad:</b><br>".$row['especialidad_nombre']."<br>
	<b>Descripci&oacute;n</b><br>".$row['cita_descripcion']."<br>
	.........................................
	<table>
		<tr>
			<td style='text-align:center'><b>!Gracias por confiar en nosotros!<br><b></td>
		</tr>
	</table>
	
	Telefono: xxx - xxx - xxx
	Direcci&oacute;n: xxx-xxx-xxx
	<div class='barcodecell'><barcode code='".$row['cita_id']."' type='I25' class='barcode' /><br>".$row['cita_id']."</div>";

}

$mpdf = new \Mpdf\Mpdf(['mode' => 'utf-8', 'format' => [80, 150]]);
$mpdf->WriteHTML($html);
$mpdf->Output();
?>