<script type="text/javascript" src="../js/medico.js?rev=<?php echo time();?>"></script>
<form autocomplete="false" onsubmit="return false">
    <div class="col-lg-12">
        <div class="box box-warning box-solid">
              <div class="box-header with-border">
                  <h3 class="box-title">Mantenimiento Auditoria</h3>

                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                </div>
                  <!-- /.box-tools -->
            </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="form-group">
                    </div>
                    <table id="tabla_medico" class="display responsive nowrap" style="width:100%">
                        <thead>
                        <tfoot>
                        <tr>
                            <th>#</th>
                            <th>Nro Doc</th>
                            <th>Medico</th>
                            <th>Nro Colegiatura</th>
                            <th>Especialidad</th>
                            <th>Sexo</th>
                            <th>Celular</th>
                            <th>Acción</th>
                        </tr>
                        </tfoot>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>#</th>
                            <th>Nro Doc</th>
                            <th>Medico</th>
                            <th>Nro Colegiatura</th>
                            <th>Especialidad</th>
                            <th>Sexo</th>
                            <th>Celular</th>
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



<script>

   $('.box').boxWidget({
    animationSpeed : 500,
    collapseTrigger: '[data-widget="collapse"]',
    removeTrigger  : '[data-widget="remove"]',
    collapseIcon   : 'fa-minus',
    espandIcon     : 'fa-plus',
    removeIcon     : 'fa-times'
   })

   

</script>
