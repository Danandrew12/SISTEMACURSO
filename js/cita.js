var tablecita;
function listar_cita(){
     tablecita = $("#tabla_cita").DataTable({
		"ordering":false,
		"paging":false,
		"searching": { "regex": true },
		"lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
		"pageLength": 10,
		"destroy":true,
		"async": false ,
		"processing": true,
		"ajax":{
			"url":"../contolador/cita/controlador_cita_listar.php",
			type:'POST'
		},
		"order":[[1,'asc']],
		"columns":[
			{"defaultContent":""},
			{"data":"cita_nroatencion"},
			{"data":"cita_feregistro"},
            {"data":"paciente"},
			{"data":"medico"},
			{"data":"cita_estatus",
			render: function (data, type, row ) {
				if(data=='PENDIENTE'){
					return "<span class='label-primary'>"+data+"</span>";
				}else if(data=='CANCELADO'){
                    return "<span class='label-danger'>"+data+"</span>";
                }
                    else{
					return "<span class='label-success'>"+data+"</span>";
				}
			}
		},
		{"defaultContent":"<button style='font-size:13px;' type='button' class='editar btn btn-primary' title='ed&iacute;tar'><i class='fa fa-edit'></i></button>&nbsp<button style='font-size:13px;' type='button' class='imprimir btn btn-danger' title='imprimir'><i class='fa fa-print'></i></button>"}
	],

	"language":idioma_espanol,
	select: true

	});
	document.getElementById("tabla_cita_filter").style.display="none";

	$('input.global_filter').on( 'keyup click', function () {
		filterGlobal();
	});
	$('input.column_filter').on( 'keyup click', function () {
		filterColumn( $(this).parents('tr').attr('data-column') );
	});

	tablecita.on('draw.dt', function (){
		var PageInfo = $('#tabla_cita').DataTable().page.info();
		tablecita.column(0, { page: 'current' }).nodes().each( function (cell, i){
			cell.innerHTML = i + 1 + PageInfo.start;
		});
	});

}

$('#tabla_cita').on('click','.editar',function(){
    var data = tablecita.row($(this).parents('tr')).data();
    if(tablecita.row(this).child.isShown()){
        var data = tablecita.row(this).data();
    }
    $("#modal_editar").modal({backdrop: 'static',keyboard:false})
    $("#modal_editar").modal('show');
    $("#txt_cita_id").val(data.cita_id);
    $("#cbm_paciente_editar").val(data.paciente_id).trigger("change");
    $("#cbm_especialidad_editar").val(data.especialidad_id).trigger("change");
    listar_doctor_combo_editar(data.especialidad_id,data.especialidad_id);
    $("#cbm_estatus").val(data.cita_estatus).trigger("change");
    $("#txt_descripcion_editar").val(data.cita_descripcion);
    
})

$('#tabla_cita').on('click','.imprimir',function(){
    var data = tablecita.row($(this).parents('tr')).data();
    if(tablecita.row(this).child.isShown()){
        var data = tablecita.row(this).data();
    }
    window.open("../libreporte/reporte/generar_ticket.php?id="+parseInt(data.cita_id)+"#zoom=100%","Ticket","scrollbars=NO");

})

function filterGlobal() {
	$('#tabla_cita').DataTable().search(
		$('#global_filter').val(),
	).draw();
 }

 function AbrirModalRegistro(){
    $("#modal_registro").modal({backdrop:'static',keyboard:false})
    $("#modal_registro").modal('show');
}

function listar_paciente_combo(){
    $.ajax({
        url:'../contolador/cita/controlador_combo_paciente_listar.php',
        type:'POST'
    }).done(function(resp){
        var data = JSON.parse(resp);
        var cadena="";
        if(data.length>0){
            for(var i=0; i < data.length; i++){
                    cadena+="<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
            
            }
            $("#cbm_paciente").html(cadena);
        }else{
            cadena+="<option value=''>NO SE ENCONTRARON REGISTROS</option>";
            $("#cbm_paciente").html(cadena);

        }
    })
}

function listar_especialidad_combo(){
    $.ajax({
        url:'../contolador/cita/controlador_combo_especialidad_listar.php',
        type:'POST'
    }).done(function(resp){
        var data = JSON.parse(resp);
        var cadena="";
        if(data.length>0){
            for(var i=0; i < data.length; i++){

                    cadena+="<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
            
            }
            $("#cbm_especialidad").html(cadena);
			var id = $("#cbm_especialidad").val();
			listar_doctor_combo(id);
        }else{
            cadena+="<option value=''>NO SE ENCONTRARON REGISTROS</option>";
            $("#cbm_especialidad").html(cadena);
        }
    })
}

function listar_doctor_combo(id){
    $.ajax({
        url:'../contolador/cita/controlador_combo_doctor_listar.php',
        type:'POST',
		data:{
			id:id
		}
    }).done(function(resp){
        var data = JSON.parse(resp);
        var cadena="";
        if(data.length>0){
            for(var i=0; i < data.length; i++){

                    cadena+="<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
            
            }
            $("#cbm_doctor").html(cadena);
           
        }else{
            cadena+="<option value=''>NO SE ENCONTRARON REGISTROS</option>";
            $("#cbm_doctor").html(cadena);
        }
    })
}

function Registrar_Cita(){
	var idpaciente = $("#cbm_paciente").val();
	var iddoctor = $("#cbm_doctor").val();
	var descripcion = $("#txt_descripcion").val();
    var idusuario = $("#txtidprincipal").val();

	if(idpaciente.length==0 || iddoctor.length==0 || descripcion.length==0){
		return Swal.fire("Mensaje de avertencia" , "Llene los campos vacio" , "warning");
	}

	$.ajax({
		url:'../contolador/cita/controlador_cita_registro.php',
		type:'POST',
		data:{
			idpa:idpaciente,
			iddo:iddoctor,
            descripcion:descripcion,
            idusuario:idusuario
		}
	}).done(function(resp){
		if(resp>0){
                Swal.fire({
                  title: 'Datos correctamente, nueva cita registrada',
                  text: "Datos de confimaci\u00F3n",
                  icon: 'success',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Imprimir Ticket'
                }).then((result) => {
                  if (result.isConfirmed) {
                      window.open("../libreporte/reporte/generar_ticket.php?id="+parseInt(resp)+"#zoom=100%","Ticket","scrollbars=NO");
                  }else{
                    $("#modal_registro").modal('hide');
                    listar_cita();
                  }
                })
				
		}else{
			Swal.fire("Mensaje De Error","Lo sentimos, no se pudo completar el registro","error");
		
		}
	})
}

function listar_paciente_combo_editar(){
    $.ajax({
        url:'../contolador/cita/controlador_combo_paciente_listar.php',
        type:'POST'
    }).done(function(resp){
        var data = JSON.parse(resp);
        var cadena="";
        if(data.length>0){
            for(var i=0; i < data.length; i++){
                    cadena+="<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
            
            }
            $("#cbm_paciente_editar").html(cadena);
        }else{
            cadena+="<option value=''>NO SE ENCONTRARON REGISTROS</option>";
            $("#cbm_paciente_editar").html(cadena);

        }
    })
}

function listar_especialidad_combo_editar(){
    $.ajax({
        url:'../contolador/cita/controlador_combo_especialidad_listar.php',
        type:'POST'
    }).done(function(resp){
        var data = JSON.parse(resp);
        var cadena="";
        if(data.length>0){
            for(var i=0; i < data.length; i++){

                    cadena+="<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
            
            }
            $("#cbm_especialidad_editar").html(cadena);
            var id = $("#cbm_especialidad_editar").val();
            listar_doctor_combo_editar(id);
        }else{
            cadena+="<option value=''>NO SE ENCONTRARON REGISTROS</option>";
            $("#cbm_especialidad_editar").html(cadena);
        }
    })
}

function listar_doctor_combo_editar(id,idmedico){
    $.ajax({
        url:'../contolador/cita/controlador_combo_doctor_listar.php',
        type:'POST',
        data:{
            id:id
        }
    }).done(function(resp){
        var data = JSON.parse(resp);
        var cadena="";
        if(data.length>0){
            for(var i=0; i < data.length; i++){

                    cadena+="<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
            
            }
            $("#cbm_doctor_editar").html(cadena);
            if (idmedico!='') {
                $("#cbm_doctor_editar").val(idmedico).trigger("change"); 
            }
        }else{
            cadena+="<option value=''>NO SE ENCONTRARON REGISTROS</option>";
            $("#cbm_doctor_editar").html(cadena);
        }
    })
}

function Editar_Cita(){
    var idcita = $("#txt_cita_id").val();
    var idpaciente = $("#cbm_paciente_editar").val();
    var iddoctor = $("#cbm_doctor_editar").val();
    var descripcion = $("#txt_descripcion_editar").val();
    var idespecialidad = $("#cbm_especialidad_editar").val();
    var estatus=$("#cbm_estatus").val();

    if(idcita.length==0 || idpaciente.length==0 || iddoctor.length==0 || descripcion.length==0 || idespecialidad.length==0){
        return Swal.fire("Mensaje de avertencia" , "Llene los campos vacio" , "warning");
    }

    $.ajax({
        url:'../contolador/cita/controlador_cita_editar.php',
        type:'POST',
        data:{
            idcita:idcita,
            idpa:idpaciente,
            iddo:iddoctor,
            idespecialidad:idespecialidad,
            descripcion:descripcion,
            estatus:estatus
        }
    }).done(function(resp){
        if(resp>0){
                Swal.fire({
                  title: 'Datos correctamente, nueva cita registrada',
                  text: "Datos de confimaci\u00F3n",
                  icon: 'success',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Imprimir Ticket'
                }).then((result) => {
                    tablecita.ajax.reload();
                  if (result.isConfirmed) {
                      window.open("../libreporte/reporte/generar_ticket.php?id="+parseInt(idcita)+"#zoom=100%","Ticket","scrollbars=NO");
                  }else{
                    $("#modal_registro").modal('hide');
                    listar_cita();
                  }
                })
                
        }else{
            Swal.fire("Mensaje De Error","Lo sentimos, no se pudo completar el registro","error");
        
        }
    })
}