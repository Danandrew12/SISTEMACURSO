var tablepaciente;
function listar_paciente(){
	tablepaciente = $("#tabla_paciente").DataTable({
		"ordering":false,
		"paging":false,
		"searching": { "regex": true },
		"lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
		"pageLength": 10,
		"destroy":true,
		"async": false ,
		"processing": true,
		"ajax":{
			"url":"../contolador/paciente/controlador_paciente_listar.php",
			type:'POST'
		},
		"order":[[1,'asc']],
		"columns":[
			{"defaultContent":""},
			{"data":"paciente_nrodocumento"},
			{"data":"paciente"},
			{"data":"paciente_direccion"},
			{"data":"paciente_sexo",
			render: function (data, type, row ){
				if(data=='M'){
					return "MASCULINO";
				}else{
					return "FEMENINO";
				}
			}
			},
			{"data":"paciente_fenac"},
			{"data":"paciente_movil"},
			{"data":"tp_sangre"},
			{"data":"paciente_estatus",
			render: function (data, type, row ){
				if(data=='ACTIVO'){
					return "<span class='label-success'>"+data+"</span>";
				}
				if(data=='INACTIVO'){
					return "<span class='label-danger'>"+data+"</span>";
				}
			}
		},
		{"defaultContent":"<button style='font-size:13px;' type='button' class='editar btn btn-primary'><i class='fa fa-edit'></i></button>"}
	],

	"language":idioma_espanol,
	select: true

	});
	document.getElementById("tabla_paciente_filter").style.display="none";

	$('input.global_filter').on( 'keyup click', function () {
		filterGlobal();
	});
	$('input.column_filter').on( 'keyup click', function () {
		filterColumn( $(this).parents('tr').attr('data-column') );
	});

	tablepaciente.on('draw.dt', function (){
		var PageInfo = $('#tabla_paciente').DataTable().page.info();
		tablepaciente.column(0, { page: 'current' }).nodes().each( function (cell, i){
			cell.innerHTML = i + 1 + PageInfo.start;
		});
	});

}

$('#tabla_paciente').on('click','.editar',function(){
	var data = tablepaciente.row($(this).parents('tr')).data();
	if(tablepaciente.row(this).child.isShown()){
		var data = tablepaciente.row(this).data();
	}
	$("#modal_editar").modal({backdrop: 'static',keyboard:false})
	$("#modal_editar").modal('show');
	$("#txt_idpaciente").val(data.paciente_id);
	$("#txt_ndoc_actual_editar").val(data.paciente_nrodocumento);
	$("#txt_ndoc_nuevo_editar").val(data.paciente_nrodocumento);
	$("#txt_nombres_editar").val(data.paciente_nombre);
	$("#txt_apepat_editar").val(data.paciente_apepat);
	$("#txt_apemat_editar").val(data.paciente_apemat);
	$("#txt_direccion_editar").val(data.paciente_direccion);
	$("#txt_movil_editar").val(data.paciente_movil);
	$("#txt_fenac_editar").val(data.paciente_fenac);
	$("#cbm_sangre_editar").select2().val(data.sag_id).trigger('change.select2');
	$("#cbm_sexo_editar").val(data.paciente_sexo).trigger("change");
	$("#cbm_estatus").val(data.paciente_estatus).trigger("change");

})

function AbrirModalRegistro(){
	$("#modal_registro").modal({backdrop: 'static',keyboard:false})
	$("#modal_registro").modal('show');
}

function filterGlobal() {
	$('#tabla_paciente').DataTable().search(
		$('#global_filter').val(),
	).draw();
}

function listar_combo_sangre(){
	$.ajax({
		"url":"../contolador/paciente/controlador_combo_sangre_listar.php",
		type:'POST'
	}).done(function(resp){
		var data = JSON.parse(resp);
		var cadena="<option value=''>Selecione</option>";
		if(data.length>0){
			for(var i=0; i < data.length; i++){
				cadena+="<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
			}
			$("#cbm_sangre").html(cadena);
			$("#cbm_sangre_editar").html(cadena);
		}else{
			cadena+="<option value=''>NO SE ENCONTRARON REGISTROS</option>";
			$("#cbm_sangre").html(cadena);
			$("#cbm_sangre_editar").html(cadena);
		}
	})
}

function Registrar_Paciente(){
	var nombres= $("#txt_nombres").val();
	var apepat= $("#txt_apepat").val();
	var apemat= $("#txt_apemat").val();
	var direccion= $("#txt_direccion").val();
	var movil= $("#txt_movil").val();
	var sexo= $("#cbm_sexo").val();
	var fcha= $("#txt_fenac").val();
	var nrodocumento= $("#txt_ndoc").val();
	var sangre= $("#cbm_sangre").val();
	
	if(nombres.length==0 || apepat.length==0 || apemat.length==0 || direccion.length==0 || movil.length==0 || sexo.length==0 || fcha==0 || nrodocumento.length==0 || sangre==0){
		return Swal.fire("Mensaje De Advertencia","Llene todos los campos","warning");
	}
	$.ajax({
		"url":"../contolador/paciente/controlador_paciente_registro.php",
		type:'POST',
		data:{
			nombres:      nombres,    
			apepat:       apepat,
			apemat:       apemat,
			direccion:    direccion,
			movil:        movil,
			sexo:         sexo,
			fcha:         fcha,
			nrodocumento: nrodocumento,
			sangre:       sangre
	
		}
	}).done(function(resp){
		if(resp>0){
			if(resp==1){
				$("#modal_registro").modal('hide');
				listar_paciente();
				LimpiarCampos();
			return	Swal.fire("Mensaje De Confirmacion","datos Guardado correctamente","success");
			}else{
				LimpiarCampos();
			return	Swal.fire("Mensaje De Advertencia","Los datos que esta registrando ya existe","warning");

			}
		}else{
			return Swal.fire("Mensaje De Error","Lo sentiemos el registro no se pudo completar","error");
		}
	})
}

function Modificar_Paciente(){
	var id= $("#txt_idpaciente").val();
	var nombres= $("#txt_nombres_editar").val();
	var apepat= $("#txt_apepat_editar").val();
	var apemat= $("#txt_apemat_editar").val();
	var direccion= $("#txt_direccion_editar").val();
	var movil= $("#txt_movil_editar").val();
	var fecha= $("#txt_fenac_editar").val();
	var sangre= $("#cbm_sangre_editar").val();
	var sexo= $("#cbm_sexo_editar").val();
	var nrodocumentoactual= $("#txt_ndoc_actual_editar").val();
	var nrodocumentonuevo= $("#txt_ndoc_nuevo_editar").val();
	var estatus= $("#cbm_estatus").val();
	
	if(id.length==0 || nombres.length==0 || apepat.length==0 || apemat.length==0 || direccion.length==0 || movil.length==0 || fecha.length==0 || sangre.length==0 || sexo.length==0 || nrodocumentonuevo.length==0){
		return Swal.fire("Mensaje De Advertencia","Llene todos los campos","warning");
	}
	$.ajax({
		"url":"../contolador/paciente/controlador_paciente_modificar.php",
		type:'POST',
		data:{
			id:           id,
			nombres:      nombres,    
			apepat:       apepat,
			apemat:       apemat,
			direccion:    direccion,
			movil:        movil,
			fecha:        fecha,
			sangre:       sangre,
			sexo:         sexo,
			nrodocumentoactual: nrodocumentoactual,
			nrodocumentonuevo: nrodocumentonuevo,
			estatus: estatus
	
		}
	}).done(function(resp){
		if(resp>0){
			if(resp==1){
				$("#modal_editar").modal('hide');
				listar_paciente();
				LimpiarCampos();
			return	Swal.fire("Mensaje De Confirmacion","Datos Actualizado correctamente","success");
			}else{
				LimpiarCampos();
			return	Swal.fire("Mensaje De Advertencia","Los datos que esta registrando ya existe","warning");

			}
		}else{
			return Swal.fire("Mensaje De Error","Lo sentimos el registro no se pudo completar","error");
		}
	})
}


function LimpiarCampos(){
	$("#txt_nombres").val("");
	$("#txt_apepat").val("");
	$("#txt_apemat").val("");
	$("#txt_direccion").val("");
	$("#txt_movil").val("");
	$("#txt_ndoc").val("");
	$("#txt_nombres_editar").val("");
	$("#txt_apepat_editar").val("");
	$("#txt_apemat_editar").val("");
	$("#txt_direccion_editar").val("");
	$("#txt_movil_editar").val("");
	$("#txt_ndoc_nuevo_editar").val("");
}