var tableauditoria;
function listar_auditoria(){
	tableauditoria = $("#tabla_auditiria").DataTable({
		"ordering":false,
		"paging":false,
		"searching": { "regex": true },
		"lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
		"pageLength": 10,
		"destroy":true,
		"async": false ,
		"processing": true,
		"ajax":{
			"url":"../contolador/auditoria/controlador_auditoria_listar.php",
			type:'POST'
		},
		"order":[[1,'asc']],
		"columns":[
			{"defaultContent":""},
			{"data":"accion"},
			{"data":"usu_id"},
			{"data":"fecha"}
	],

	"language":idioma_espanol,
	select: true

	});
	document.getElementById("tabla_auditiria_filter").style.display="none";

	$('input.global_filter').on( 'keyup click', function () {
		filterGlobal();
	});
	$('input.column_filter').on( 'keyup click', function () {
		filterColumn( $(this).parents('tr').attr('data-column') );
	});

	tableauditoria.on('draw.dt', function (){
		var PageInfo = $('#tabla_auditiria').DataTable().page.info();
		tableauditoria.column(0, { page: 'current' }).nodes().each( function (cell, i){
			cell.innerHTML = i + 1 + PageInfo.start;
		});
	});

}