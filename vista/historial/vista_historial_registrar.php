<script type="text/javascript" src="../js/historial.js?rev=<?php echo time();?>"></script>
<form autocomplete="false" onsubmit="return false">
  <div class="col-md-12">
    <div class="box box-warning box-solid">
      <div class="box-header with-border">
        <h3 class="box-title">Mantenimiento De Registro De Historial Médico</h3>
          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
            </button>
          </div>
                <!-- /.box-tools -->
      </div>
      <div class="box-body">
        <div class="col-lg-2">
          <label for="">Código historial</label>
          <input type="text" id="txt_codigohistorial" class="form-control" disabled>
        </div>
        <div class="col-lg-8">
          <label for="">Paciente</label>
          <input type="text" id="txt_paciente" class="form-control" disabled>
        </div>
        <div class="col-lg-2">
          <label for=""&nbsp;></label><br>
          <button class="btn btn-success" onclick="AbrirModalConsulta()"><i class="fa fa-search"></i>Buscar Consulta</button>
        </div>
        <div class="col-lg-6">
          <label for="">Descripción de la consulta</label>
          <textarea id="txt_desconsulta" cols="30" rows="3" disabled class="form-control"></textarea>
        </div>
        <div class="col-lg-6">
          <label for="">Diagnostico de la consulta</label>
          <textarea id="txt_diagnconsulta" cols="30" rows="3" disabled class="form-control"></textarea>
        </div>
        <input type="text" id="txt_idconsulta" hidden>
        <div class="col-md-12"><br>
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header d-flex p-0">
                  <ul class="nav nav-pills ml-auto p-2">
                    <li class="nav-item"><a class="nav-link active" href="#tab_1" data-toggle="tab">Procedimientos</a></li>
                    <li class="nav-item"><a class="nav-link" href="#tab_2" data-toggle="tab">Insumo</a></li>
                    <li class="nav-item"><a class="nav-link" href="#tab_3" data-toggle="tab">Medicamentos</a></li>
                  </ul>
                </div>
                <div class="card-body">
                  <div class="tab-content">
                    <div class="tab-pane active" id="tab_1">
                      <div class="row">
                        <div class="col-lg-10">
                          <label for="">Procedimientos</label>
                          <select class="js-example-basic-single" name="state" id="cbm_procedimiento" style="width: 100%;">
                          </select>
                        </div>
                        <div class="col-lg-2">
                          <label for="">&nbsp;</label><br>
                          <button class="btn btn-primary" style="width: 100%;" onclick="Agregar_procedimiento()"><i class="fa fa-plu-square"></i>&nbsp;Agregar</button>
                        </div>
                        <div class="col-lg-12" table-responsive><br>
                          <table id="tabla_procedimiento" style="width:100%" class="table">
                            <thead>
                              <th>ID</th>
                              <th>Procedimientos</th>
                              <th>Acción</th>
                            </thead>
                            <tbody id="tbody_tabla_procedimiento">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                    <div class="tab-pane" id="tab_2">
                      <div class="row">
                        <div class="col-lg-6">
                          <label for="">Insumos</label>
                          <select class="js-example-basic-single" name="state" id="cbm_insumo" style="width: 100%;">
                          </select>
                        </div>
                        <div class="col-lg-2">
                          <label for="">Stock Actual</label>
                          <input type="text" class="form-control" id="stock_insumo" disabled>
                        </div>
                        <div class="col-lg-2">
                          <label for="">Cantidad Agregar</label>
                          <input type="text" class="form-control" id="txt_cantidad_agregar">
                        </div>
                        <div class="col-lg-2">
                          <label for="">&nbsp;</label><br>
                          <button class="btn btn-primary" style="width: 100%;" onclick="Agregar_Insumo()"><i class="fa fa-plu-square"></i>&nbsp;Agregar</button>
                        </div>
                        <div class="col-lg-12" table-responsive><br>
                          <table id="tabla_insumo" style="width:100%" class="table">
                            <thead>
                              <th>ID</th>
                              <th>Insumo</th>
                              <th>Cantidad</th>
                              <th>Acción</th>
                            </thead>
                            <tbody id="tbody_tabla_insumo">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                    <div class="tab-pane" id="tab_3">
                      <div class="row">
                        <div class="col-lg-6">
                          <label for="">Medicamentos</label>
                          <select class="js-example-basic-single" name="state" id="cbm_medicamento" style="width: 100%;">
                          </select>
                        </div>
                        <div class="col-lg-2">
                          <label for="">Stock Actual</label>
                          <input type="text" class="form-control" id="stock_medicamento" disabled>
                        </div>
                        <div class="col-lg-2">
                          <label for="">Cantidad Agregar</label>
                          <input type="text" class="form-control" id="txt_cantidad_agregar_medicamento">
                        </div>
                        <div class="col-lg-2">
                          <label for="">&nbsp;</label><br>
                          <button class="btn btn-primary" style="width: 100%;" onclick="Agregar_Medicamento()"><i class="fa fa-plu-square"></i>&nbsp;Agregar
                          </button>
                        </div>
                        <div class="col-lg-12" table-responsive><br>
                          <table id="tabla_medicamento" style="width:100%" class="table">
                            <thead>
                              <th>ID</th>
                              <th>Medicamento</th>
                              <th>Cantidad</th>
                              <th>Acción</th>
                            </thead>
                            <tbody id="tbody_tabla_medicamento">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-12" style="text-align: center">
          <button class="btn btn-success btn-lg" onclick="Registrar_Historial()">Registrar</button>
        </div>
      </div>
    </div>
  </div>
</form>
<div class="modal lg" id="modal_consulta" role="dialog">
  <div class="col-lg-12 table-responsive">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"><b>Listado De Consulta Medica</b></h4>
        </div>
        <div class="modal-body">
          <div class="row">
            <table id="tabla_consulta_historial" class="display responsive nowrap" style="width:100%">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Fecha</th>
                  <th>Codigo Historial</th>
                  <th>Paciente</th>
                  <th>Acción</th>
                </tr>
              </thead>
            </table>
          </div>
        </div>
      </div>
      <div class="modal-footer">
      </div>
    </div>  
  </div>
</div>

<script>
    $(document).ready(function(){
      $('.js-example-basic-single').select2();
      listar_procedimiento_combo();
      listar_insumo_combo();
      listar_medicamento_combo();
  });
    $("#cbm_medicamento").change(function() {
       var  $idmedicamento=$("#cbm_medicamento").val();
       TraerStockMedicamento($idmedicamento);
  });
    $("#cbm_insumo").change(function() {
       var  $idinsumo=$("#cbm_insumo").val();
       TraerStockInsumo($idinsumo);
  });


  $('.box').boxWidget({
      animationSpeed : 500,
      collapseTrigger: '[data-widget="collapse"]',
      removeTrigger  : '[data-widget="remove"]',
      collapseIcon   : 'fa-minus',
      espandIcon     : 'fa-plus',
      removeIcon     : 'fa-times'
  })
</script>
