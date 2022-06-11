var tablemedico;
function listar_medico(){
	tablemedico = $("#tabla_medico").DataTable({
		"ordering":false,
		"paging":false,
		"searching": { "regex": true },
		"lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
		"pageLength": 10,
		"destroy":true,
		"async": false ,
		"processing": true,
		"ajax":{
			"url":"../contolador/medico/controlador_medico_listar.php",
			type:'POST'
		},
		"order":[[1,'asc']],
		"columns":[
			{"defaultContent":""},
			{"data":"medico_nrodocumento"},
			{"data":"medico"},
			{"data":"medico_colegiatura"},
			{"data":"especialidad_nombre"},
			{"data":"medico_sexo",
			render: function (data, type, row ){
				if(data=='M'){
					return "MASCULINO";
				}else{
					return "FEMENINO";
				}
			}
		},
		{"data":"medico_fenac"},
		{"data":"medico_movil"},
		{"data":"tp_sangre"},
		{"defaultContent":"<button style='font-size:13px;' type='button' class='editar btn btn-primary'><i class='fa fa-edit'></i></button>"}
	],

	"language":idioma_espanol,
	select: true

	});
	document.getElementById("tabla_medico_filter").style.display="none";

	$('input.global_filter').on( 'keyup click', function () {
		filterGlobal();
	});
	$('input.column_filter').on( 'keyup click', function () {
		filterColumn( $(this).parents('tr').attr('data-column') );
	});

	tablemedico.on('draw.dt', function (){
		var PageInfo = $('#tabla_medico').DataTable().page.info();
		tablemedico.column(0, { page: 'current' }).nodes().each( function (cell, i){
			cell.innerHTML = i + 1 + PageInfo.start;
		});
	});

}

$('#tabla_medico').on('click','.editar',function(){
	var data = tablemedico.row($(this).parents('tr')).data();
	if(tablemedico.row(this).child.isShown()){
		var data = tablemedico.row(this).data();
	}
	$("#modal_editar").modal({backdrop: 'static',keyboard:false})
	$("#modal_editar").modal('show');
	$("#id_medico").val(data.medico_id);
	$("#txt_nombres_editar").val(data.medico_nombre);
	$("#txt_apepat_editar").val(data.medico_apepart);
	$("#txt_apemat_editar").val(data.medico_apemart);
	$("#txt_direccion_editar").val(data.medico_direccion);
	$("#txt_movil_editar").val(data.medico_movil);
	$("#cbm_sexo_editar").val(data.medico_sexo).trigger("change");
	$("#txt_fenac_editar").val(data.medico_fenac);
	$("#cbm_sangre_editar").val(data.sag_id).trigger("change");
	$("#txt_ndoc_editar_actual").val(data.medico_nrodocumento);
	$("#txt_ndoc_editar_nuevo").val(data.medico_nrodocumento);
	$("#txt_ncol_editar_actual").val(data.medico_colegiatura);
	$("#txt_ncol_editar_nuevo").val(data.medico_colegiatura);
	$("#cbm_especialidad_editar").val(data.especialidad_id).trigger("change");
	$("#id_usuario").val(data.usu_id);
	$("#txt_usu_editar").val(data.usu_nombre);
	$("#cbm_rol_editar").val(data.rol_id).trigger("change");
	$("#txt_email_editar").val(data.usu_email);

	
})

function filterGlobal() {
	$('#tabla_medico').DataTable().search(
		$('#global_filter').val(),
	).draw();
}

function AbrirModalRegistro(){
	$("#modal_registro").modal({backdrop: 'static',keyboard:false})
	$("#modal_registro").modal('show');
	
}

function listar_combo_rol(){
	$.ajax({
		"url":"../contolador/usuario/controlador_combo_rol_listar.php",
		type:'POST'
	}).done(function(resp){
		var data = JSON.parse(resp);
		var cadena="";
		if(data.length>0){
			for(var i=0; i < data.length; i++){
				if (data[i][0]==3) {
					cadena+="<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";

				}
			}
			$("#cbm_rol").html(cadena);
			$("#cbm_rol_editar").html(cadena);
		}else{
			cadena+="<option value=''>NO SE ENCONTRARON REGISTROS</option>";
			$("#cbm_rol").html(cadena);
			$("#cbm_rol_editar").html(cadena);
		}
	})
}

function listar_combo_especialidad(){
	$.ajax({
		"url":"../contolador/medico/controlador_combo_especialidad_listar.php",
		type:'POST'
	}).done(function(resp){
		var data = JSON.parse(resp);
		var cadena="";
		if(data.length>0){
			for(var i=0; i < data.length; i++){
				cadena+="<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
			}
			$("#cbm_especialidad").html(cadena);
			$("#cbm_especialidad_editar").html(cadena);
		}else{
			cadena+="<option value=''>NO SE ENCONTRARON REGISTROS</option>";
			$("#cbm_especialidad").html(cadena);
			$("#cbm_especialidad_editar").html(cadena);
		}
	})
}

function listar_combo_sangre(){
	$.ajax({
		"url":"../contolador/medico/controlador_combo_sangre_listar.php",
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

function Registrar_Medico(){
	var nombres= $("#txt_nombres").val();
	var apepat= $("#txt_apepat").val();
	var apemat= $("#txt_apemat").val();
	var direccion= $("#txt_direccion").val();
	var movil= $("#txt_movil").val();
	var sangre= $("#cbm_sangre").val();
	var sexo= $("#cbm_sexo").val();
	var fenac= $("#txt_fenac").val();
	var ndoc= $("#txt_ndoc").val();
	var ncol= $("#txt_ncol").val();
	var especialidad= $("#cbm_especialidad").val();
	var usuario= $("#txt_usu").val();
	var contra= $("#txt_contra").val();
	var rol= $("#cbm_rol").val();
	var email= $("#txt_email").val();
	var validaremail=$("#validar_email").val();
	if (validaremail=="incorrecto"){
		return Swal.fire("Mensaje de advertencia","El Email ingresado no tiene el formato correcto","warning")
	}

	if(nombres.length==0 || apepat.length==0 || apemat.length==0 || direccion.length==0 || movil.length==0 || sangre.length==0 || sexo.length==0 || fenac.length==0 || ndoc.length==0 || ncol.length==0 || especialidad.length==0 || usuario.length==0 || contra.length==0 || rol.length==0 || email.length==0){
		return Swal.fire("Mensaje De Advertencia","Llene todos los campos","warning");
	}
	$.ajax({
		"url":"../contolador/medico/controlador_medico_registro.php",
		type:'POST',
		data:{
			nombres:      nombres,    
			apepat:       apepat,
			apemat:       apemat,
			direccion:    direccion,
			movil:        movil,
			sangre:       sangre,
			sexo:         sexo,
			fenac:        fenac,
			ndoc:         ndoc,
			ncol:         ncol,
			especialidad: especialidad,
			usuario:      usuario,
			contra:       contra,
			rol:          rol,
			email:        email
	
		}
	}).done(function(resp){
		if(resp>0){
			if(resp==1){
				$("#modal_registro").modal('hide');
				listar_medico();
				 LimpiarCampos();
				Swal.fire("Mensaje De Confirmacion","datos Guardado correctamente","success");
			}else{
				 LimpiarCampos();
				Swal.fire("Mensaje De Advertencia","Los datos que esta registrando ya existe","warning");

			}
		}else{
			Swal.fire("Mensaje De Error","Lo sentiemos el registro no se pudo completar","error");
		}
	})
}

function Editar_Medico(){
	var idmedico= $("#id_medico").val();
	var nombres= $("#txt_nombres_editar").val();
	var apepat= $("#txt_apepat_editar").val();
	var apemat= $("#txt_apemat_editar").val();
	var direccion= $("#txt_direccion_editar").val();
	var movil= $("#txt_movil_editar").val();
	var sexo= $("#cbm_sexo_editar").val();
	var fenac= $("#txt_fenac_editar").val();
	var sangre= $("#cbm_sangre_editar").val();
	var ndocactual= $("#txt_ndoc_editar_actual").val();
	var ndocnuevo= $("#txt_ndoc_editar_nuevo").val();
	var ncolactual= $("#txt_ncol_editar_actual").val();
	var ncolnuevo= $("#txt_ncol_editar_nuevo").val();
	var especialidad= $("#cbm_especialidad_editar").val();
	var idusuario= $("#id_usuario").val();
	var email= $("#txt_email_editar").val();
	var validaremail=$("#validar_email_editar").val();
	if (validaremail=="incorrecto"){
		return Swal.fire("Mensaje de advertencia","El Email ingresado no tiene el formato correcto","warning")
	}

	if(nombres.length==0 || apepat.length==0 || apemat.length==0 || direccion.length==0 || movil.length==0 || sexo.length==0 || fenac.length==0 || sangre.length==0 || ndocnuevo.length==0 || ncolnuevo.length==0 || especialidad.length==0 || email.length==0){
		return Swal.fire("Mensaje De Advertencia","Llene todos los campos","warning");
	}
	$.ajax({
		"url":"../contolador/medico/controlador_medico_editar.php",
		type:'POST',
		data:{
			idmedico:     idmedico,
			nombres:      nombres,    
			apepat:       apepat,
			apemat:       apemat,
			direccion:    direccion,
			movil:        movil,
			sexo:         sexo,
			fenac:        fenac,
			sangre:       sangre,
			ndocactual:   ndocactual,
			ndocnuevo:    ndocnuevo,
			ncolactual:   ncolactual,
			ncolnuevo:    ncolnuevo,
			especialidad: especialidad,
			idusuario:    idusuario,
			email:        email
	
		}
	}).done(function(resp){
		if(resp>0){
		if(resp==1){
			$("#modal_editar").modal('hide');
			listar_medico();
			Swal.fire("Mensaje De Confirmacion","datos Actualizados correctamente","success");
		}else{
			Swal.fire("Mensaje De Advertencia","Los datos que esta registrando ya existe","warning");

		}
	}else{
			Swal.fire("Mensaje De Error","Lo sentiemos el registro no se pudo completar","error");
		}
	})
}

function LimpiarCampos(){

	$("#txt_nombres_editar").val("");
	$("#txt_apepat_editar").val("");
	$("#txt_apemat_editar").val("");
	$("#txt_direccion_editar").val("");
	$("#txt_movil_editar").val("");
	$("#txt_ndoc_editar_nuevo").val("");
	$("#txt_ncol_editar_nuevo").val("");
	$("#cbm_especialidad_editar").val("");
	$("#txt_email_editar").val("");
	$("#txt_nombres").val("");
	$("#txt_apepat").val("");
	$("#txt_apemat").val("");
	$("#txt_direccion").val("");
	$("#txt_movil").val("");
	$("#txt_fenac").val("");
	$("#txt_ndoc").val("");
	$("#txt_ncol").val("");
	$("#txt_usu").val("");
	$("#txt_contra").val("");
	$("#txt_email").val("");


	

}