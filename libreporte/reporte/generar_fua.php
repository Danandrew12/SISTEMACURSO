<?php 
  session_start();
  if(!isset($_SESSION['S_IDUSUARIO'])){
    header('location: ../../Login/index.php');
  }
  
?>

<?php

require_once __DIR__ . '/../vendor/autoload.php';
require_once '../../conexion_reporte/r_conexion.php';
$consulta = " SELECT
  consulta.consulta_descripcion, 
  consulta.consulta_diagnostico, 
  cita.cita_descripcion, 
  paciente.paciente_nombre, 
  paciente.paciente_apepat, 
  paciente.paciente_apemat, 
  paciente.paciente_direccion, 
  paciente.paciente_movil, 
  paciente.paciente_sexo, 
  paciente.paciente_nrodocumento, 
  especialidad.especialidad_nombre, 
  fua.fua_id, 
  cita.cita_id, 
  medico.medico_nombre, 
  medico.medico_apepart, 
  medico.medico_apemart, 
  consulta.consulta_id
FROM
  fua
  INNER JOIN
  consulta
  ON 
    fua.consulta_id = consulta.consulta_id
  INNER JOIN
  cita
  ON 
    consulta.cita_id = cita.cita_id
  INNER JOIN
  paciente
  ON 
    cita.paciente_id = paciente.paciente_id
  INNER JOIN
  especialidad
  ON 
    cita.especialidad_id = especialidad.especialidad_id
  INNER JOIN
  medico
  ON 
    cita.medico_id = medico.medico_id where fua.fua_id ='".$_GET['id']."'";
    $resultado = $mysqli->query($consulta);
    while ($row = $resultado->fetch_assoc()){
      $html='<div style="text-align:center"><h1><u>REPORTE DE FUA</u></h1></div>
      <div style="float:left;width:120px">
          <span><b>DNI: </b>'.$row['paciente_nrodocumento'].'</span>
      </div>
      <div style="float:left;width:400px">
          <span><b>PACIENTE: </b>'.utf8_decode($row['paciente_nombre']).' '.utf8_decode($row['paciente_apepat']).' '.utf8_decode($row['paciente_apemat']).'</span>
      </div>
      <div style="float:right;width:100px">
          <span><b>SEXO: </b>'.$row['paciente_sexo'].'</span>
      </div><br>
      <div style="width:600px"><br>
      <span><b>DIRECCIÔN: </b>'.utf8_decode($row['paciente_direccion']).'</span>
      </div>
      <div style="width:700px;text-align:center"><br>
          <h2><u>DATOS DE LA CITA</u></h2>
      </div>
      <div style="float:left;width:120px">
      <span><b>Nro. Cita: </b>'.$row['cita_id'].'</span>
      </div>
      <div style="float:left;width:400px">
        <span><b>Medico: </b>'.utf8_decode($row['medico_nombre']).' '.utf8_decode($row['medico_apepart']).' '.utf8_decode($row['medico_apemart']).'</span>
      </div>
      <div style="float:right;width:150px">
          <span><b>ESPECIALIDAD: </b>'.$row['especialidad_nombre'].'</span>
      </div><br>
      <div style="width:700px"><br><br>
          <span><b>Descrición de la cita: </b>'.utf8_decode($row['cita_descripcion']).'</span>
      </div><br>

      <div style="width:700px;text-align:center"><br>
          <h2><u>DATOS DE LA CONSULTA MEDICA</u></h2>
      </div>
      <div style="float:left;width:120px">
      <span><b>Nro. De la consulta: </b>'.utf8_decode($row['consulta_id']).'</span>
      </div>
      <div style="width:700px"><br><br>
          <span><b>Descrición de la consulta: </b>'.utf8_decode($row['consulta_descripcion']).'</span>
      </div><br>
      <div style="width:700px"><br><br>
          <span><b>Diagnostico de la consulta: </b>'.utf8_decode($row['consulta_diagnostico']).'</span>
      </div><br>
      <div style="width:700px;text-align:center"><br>
          <h2><u>MEDICAMENTOS</u></h2>
      </div>
      <table style="width:100%; border-collapse:collapse" border="1">
        <thead>
          <tr bgcolor="#C0C0C0">
            <th>#</th>
            <th>Medicamento</th>
            <th>Cantidad</th>
          </tr>
        </thead>';
        $consultamedicamento = "SELECT
        medicamento.medicamento_nombre, 
        detalle_medicamento.detame_cantidad
        FROM
        detalle_medicamento
        INNER JOIN
        medicamento
        ON 
        detalle_medicamento.medicamento_id = medicamento.medicamento_id where detalle_medicamento.fua_id ='".$_GET['id']."'";
        $resultadomedicamento = $mysqli->query($consultamedicamento);
        $contadormedicamento=0;
        while ($rowmedicamento = $resultadomedicamento->fetch_assoc()){
          $contadormedicamento++;
          $html.='<tr> 
            <td style="text-align:center">'.$contadormedicamento.'</td>
            <td style="text-align:center">'.utf8_decode($rowmedicamento['medicamento_nombre']).'</td>
            <td style="text-align:center">'.$rowmedicamento['detame_cantidad'].'</td>

          '; 
        }
        $html.='</tr><tbody>
        </tbody>
      </table>
      <div style="width:700px;text-align:center"><br>
          <h2><u>INSUMOS</u></h2>
      </div>
      <table style="width:100%; border-collapse:collapse" border="1">
        <thead>
          <tr bgcolor="#C0C0C0">
            <th>#</th>
            <th>Insumo</th>
            <th>Cantidad</th>
          </tr>
        </thead>
      ';
        $consultainsumo = "SELECT
        insumo.insumo_nombre, 
        detalle_insumo.detain_cantidad
        FROM
        detalle_insumo
        INNER JOIN
        insumo
        ON 
        detalle_insumo.insumo_id = insumo.insumo_id where detalle_insumo.fua_id  = '".$_GET['id']."'";
        $resultadoinsumo = $mysqli->query($consultainsumo);
        $contadorinsumo=0;
        while ($rowinsumo = $resultadoinsumo->fetch_assoc()){
          $contadorinsumo++;
          $html.='<tr> 
            <td style="text-align:center">'.$contadorinsumo.'</td>
            <td style="text-align:center">'.utf8_decode($rowinsumo['insumo_nombre']).'</td>
            <td style="text-align:center">'.$rowinsumo['detain_cantidad'].'</td>

          '; 
        }
        $html.='</tr><tbody>
        </tbody>
      </table>
        <div style="width:700px;text-align:center"><br>
            <h2><u>PROCEDIMIENTOS</u></h2>
        </div>
        <table style="width:100%; border-collapse:collapse" border="1">
          <thead>
            <tr bgcolor="#C0C0C0">
              <th>#</th>
              <th>Procedimiento</th>
            </tr>
          </thead>
      ';
      $consultaprocedimiento = "SELECT
      procedimiento.procedimiento_nombre
      FROM
      detalle_procedimiento
      INNER JOIN
      procedimiento
      ON 
      detalle_procedimiento.procedimiento_id = procedimiento.procedimiento_id where detalle_procedimiento.fua_id  = '".$_GET['id']."'";
        $resultadoprocedimiento = $mysqli->query($consultaprocedimiento);
        $contadorprocedimiento=0;
        while ($rowprocedimiento = $resultadoprocedimiento->fetch_assoc()){
          $contadorprocedimiento++;
          $html.='<tr> 
            <td style="text-align:center">'.$contadorprocedimiento.'</td>
            <td style="text-align:center">'.utf8_decode($rowprocedimiento['procedimiento_nombre']).'</td>

          '; 
        }
        $html.='</tr><tbody>
        </tbody>
      </table>';
}


$mpdf = new \Mpdf\Mpdf(['mode' => 'utf-8', 'format' => 'A4']);
$mpdf->WriteHTML($html);
$mpdf->Output();
?>