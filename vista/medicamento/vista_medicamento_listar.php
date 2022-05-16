<script type="text/javascript" src="../js/medicamento.js?rev=<?php echo time();?>"></script>
<form autocomplete="false" onsubmit="return false">
<div class="col-md-12">
      <div class="box box-warning box-solid">
          <div class="box-header with-border">
              <h3 class="box-title">Mantenimiento De Medicamento</h3>

            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
            </div>
              <!-- /.box-tools -->
        </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="form-group">
                <div class="col-lg-10">
                  <div class="input-group">
                    <input type="text" class="global_filter form-control" id="global_filter" placeholder="Ingresar dato a buscar">
                    <span class="input-group-addon"><i class="fa fa-search"></i></span>
                  </div>
                </div>
                <div class="col-lg-2">
                    <button class="btn btn-danger" style="width:100%" onclick="AbrilModalRegistro()" ><i class="glyphicon glyphicon-plus"></i> Nuevo Registro </button>
                </div>
              </div>
              <table id="tabla_medicamento" class="display responsive nowrap" style="width:100%">
                <thead>
                  <tfoot>
                  <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Alias</th>
                    <th>Stock</th>
                    <th>Fecha Registro</th>
                    <th>Estatus</th>
                    <th>Acción</th>
                  </tr>
                  </tfoot>
                </thead>
                <tfoot>
                  <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Alias</th>
                    <th>Stock</th>
                    <th>Fecha Registro</th>
                    <th>Estatus</th>
                    <th>Acción</th>
                  </tr>
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
    </div>
          <!-- /.box -->
</div>
</form>
<div class="modal fade" id="modal_registro" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title"><b>Registro De Medicamento</b></h4>
            </div>

            <div class="modal-body">
                 <div class="col-lg-12">
                      <label for="">Nombre</label>
                      <input type="text" class="form-control" id="txt_medicamento"placeholder="Ingrese el medicamento" maxlength="50" onkeypress="return soloLetras(event)"><br>
                 </div>
                 <div class="col-lg-12">
                      <label for="">Alias</label>
                      <input type="text" class="form-control" id="txt_alias"placeholder="Ingrese el alias del medicamento" maxlength="50" onkeypress="return soloLetras(event)"><br>
                 </div>

                  <div class="col-lg-12">
                      <label for="">Stock</label>
                      <input type="text" class="form-control" id="txt_stock"placeholder="Ingrese stock" maxlength="5" onkeypress="return soloNumeros(event)"><br>
                 </div>

                 <div class="col-lg-12">
                      <label for="">Estatus</label>
                      <select class="js-example-basic-single" name="state" id="cbm_estatus" style="width: 100%;">
                           <option value="ACTIVO">ACTIVO</option>
                           <option value="INACTIVO">INACTIVO</option>
                      </select><br><br>
                </div>

          </div>
          <div class="modal-footer">
                <button class="btn btn-primary" onclick="Registrar_Medicamento()"><i class="fa fa-check"><b>&nbsp;Registrar</b></i></button>
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"><b>&nbsp;Cerrar</b></i></button>
          </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal_editar" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title"><b>Editar De Medicamento</b></h4>
            </div>

            <div class="modal-body">
                 <div class="col-lg-12">
                    <input type="text" id="txtidmedicamento" hidden>
                      <label for="">Nombre</label>
                      <input type="text" id="txt_medicamento_actual_editar"placeholder="Ingrese el medicamento" maxlength="50" onkeypress="return soloLetras(event)" hidden>
                      <input type="text" class="form-control" id="txt_medicamento_nuevo_editar"placeholder="Ingrese el medicamento" maxlength="50" onkeypress="return soloLetras(event)"><br>
                 </div>
                 <div class="col-lg-12">
                      <label for="">Alias</label>
                      <input type="text" class="form-control" id="txt_alias_editar"placeholder="Ingrese el alias del medicamento" maxlength="50" onkeypress="return soloLetras(event)"><br>
                 </div>

                  <div class="col-lg-12">
                      <label for="">Stock</label>
                      <input type="text" class="form-control" id="txt_stock_editar"placeholder="Ingrese stock" maxlength="5" onkeypress="return soloNumeros(event)"><br>
                 </div>

                 <div class="col-lg-12">
                      <label for="">Estatus</label>
                      <select class="js-example-basic-single" name="state" id="cbm_estatus_editar" style="width: 100%;">
                           <option value="ACTIVO">ACTIVO</option>
                           <option value="INACTIVO">INACTIVO</option>
                           <option value="AGOTADO">AGOTADO</option>
                      </select><br><br>
                </div>

          </div>
          <div class="modal-footer">
                <button class="btn btn-primary" onclick="Modificar_Medicamento()"><i class="fa fa-check"><b>&nbsp;Editar</b></i></button>
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"><b>&nbsp;Cerrar</b></i></button>
          </div>
        </div>
    </div>
</div>

<script>
  $(document).ready(function(){
    listar_medicamento();
    $('.js-example-basic-single').select2();
    $("#modal_registro").on('shown.bs.modal',function(){
      $("#txt_medicamento").focus();
    })

  } );

   

</script>