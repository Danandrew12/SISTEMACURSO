<script type="text/javascript" src="../js/historial.js?rev=<?php echo time();?>"></script>
<form autocomplete="false" onsubmit="return false">
  <div class="col-md-12">
    <div class="box box-warning box-solid">
      <div class="box-header with-border">
        <h3 class="box-title">Mantenimiento De Historial Médico</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
        </div>
              <!-- /.box-tools -->
        </div>
          <!-- /.box-header -->
          <div class="box-body">
            <div class="form-group">
              <div class="col-lg-4">
                <label for="">Fecha Inicio</label>
                <input type="date" id="txt_fechainicio" class="form-control">
              </div>
              <div class="col-lg-4">
                <label for="">Fecha Fin</label>
                <input type="date" id="txt_fechafin" class="form-control">
              </div>
              <div class="col-lg-2">
                <label for="">&nbsp;</label><br>
                <button class="btn btn-success" style="width:100%" onclick="listar_historial()"><i class="glyphicon glyphicon-search"></i>Buscar</button>
              </div>
              <div class="col-lg-2">
                <label for="">&nbsp;</label><br>
                <button class="btn btn-danger" style="width:100%" onclick="cargar_contenido('contenido_principal','historial/vista_historial_registrar.php')"><i class="glyphicon glyphicon-plus"></i>Nuevo Registro</button>
              </div>
            </div>
            <div class="col-lg-12 table-responsive">
              <table id="tabla_historial" class="display responsive nowrap" style="width:100%">
                <thead>
                  <tfoot>
                    <tr>
                      <th>#</th>
                      <th>Fecha</th>
                      <th>Nro Documento</th>
                      <th>Paciente</th>
                      <th>Diagnostico</th>
                      <th>Ver Detalle del Fua</th>
                      <th>Reportes</th>
                    </tr>
                  </tfoot>
                </thead>
                <tfoot>
                  <tr>
                    <th>#</th>
                      <th>Fecha</th>
                      <th>Nro Documento</th>
                      <th>Paciente</th>
                      <th>Diagnostico</th>
                      <th>Ver Detalle del Fua</th>
                      <th>Reportes</th>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
              <!-- /.box-body -->
    </div>
            <!-- /.box -->
  </div>
</form>

<div class="modal lg" id="modal_detalle" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <div class="row">
          <div class="col-md-12">
            <div class="modal-header">
            <h4 class="modal-title"><b>Detalle De Fua</b></h4>
            </div>
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
                          <div class="col-lg-12 table-responsive" >
                            <table id="tabla_procedimiento" class="display responsive nowrap" style="width:100%">
                              <thead>
                                <tfoot>
                                  <tr>
                                    <th>#</th>
                                    <th>Nombre</th>
                                  </tr>
                                </tfoot>
                              </thead>
                              <tfoot>
                                <tr>
                                  <th>#</th>
                                  <th>Nombre</th>
                                </tr>
                              </tfoot>
                            </table>
                          </div>
                        </div>
                      </div>
                      <div class="tab-pane" id="tab_2">
                        <div class="row">
                          <div class="col-lg-12 table-responsive">
                            <table id="tabla_insumo" class="display responsive nowrap" style="width:100%">
                              <thead>
                                <tfoot>
                                  <tr>
                                    <th>#</th>
                                    <th>Insumo</th>
                                    <th>Cantidad</th>
                                  </tr>
                                </tfoot>
                              </thead>
                              <tfoot>
                                <tr>
                                  <th>#</th>
                                  <th>Insumo</th>
                                  <th>Cantidad</th>
                                </tr>
                              </tfoot>
                            </table>
                          </div>
                        </div>
                      </div>
                      <div class="tab-pane" id="tab_3">
                        <div class="row">
                          <div class="col-lg-12 table-responsive">
                            <table id="tabla_medicamento" class="display responsive nowrap" style="width:100%">
                              <thead>
                                <tfoot>
                                  <tr>
                                    <th>#</th>
                                    <th>Medicamento</th>
                                    <th>Cantidad</th>
                                  </tr>
                                </tfoot>
                              </thead>
                              <tfoot>
                                <tr>
                                  <th>#</th>
                                  <th>Insumo</th>
                                  <th>Cantidad</th>
                                </tr>
                              </tfoot>
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
        </div>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"><b>&nbsp;Cerrar</b></i></button>
      </div> 
    </div>
  </div>
</div>

<div class="modal lg" id="modal_diagnostico" role="dialog">
  <div class="col-lg-12 table-responsive">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title"><b>Diagnostio De La Cita</b></h4>
            </div>

            <div class="modal-body">
              <div class="row">
                <div class="col-lg-12">
                  <textarea class="form-control" id="txt_diagnostico_fua" rows="5" disabled></textarea>
                </div>
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
      listar_historial();
      $('.js-example-basic-single').select2();
      var n = new Date();
      var y = n.getFullYear(); 
      var m = n.getMonth()+1; 
      var d = n.getDate(); 
      if(d<10){
        d='0'+d;
      }
      
      if(m<10){
        m='0'+m;
      }

      document.getElementById("txt_fechainicio").value = y + "-" + m + "-" + d;
      document.getElementById("txt_fechafin").value = y + "-" + m + "-" + d;
      $("#modal_registro").on('shown.bs.modal',function(){
        $("#txt_especialidad").focus();
      });

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