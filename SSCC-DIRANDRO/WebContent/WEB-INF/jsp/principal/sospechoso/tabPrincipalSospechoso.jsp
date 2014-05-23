<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.controls{
	margin-top: 3px;
}
</style>
<script>
function init(sospechoso){
	//CABECERA...
	$("#hdrCodigoUnicoDeIdentificacion").empty();
	$("#hdrPrimerApellido").empty();
	$("#hdrSegundoApellido").empty();
	$("#hdrPrenombres").empty();
	$("#hdrAlias").empty();
	$("#hdrCaso").empty();
	//
	$("#hdrCodigoUnicoDeIdentificacion").append(sospechoso.codigoUnicoDeIdentificacion);
	$("#hdrPrimerApellido").append(sospechoso.primerApellido);
	$("#hdrSegundoApellido").append(sospechoso.segundoApellido);
	$("#hdrPrenombres").append(sospechoso.preNombres);
	$("#hdrAlias").append(sospechoso.alias);
	//...FINAL CABECERA
	//$("#hdrCaso").append(sospechoso.);
	//TAB PRINCIPAL
	$("#spnCodigoUnicoDeIdentificacion").empty();
	$("#spnPrimerApellido").empty();
	$("#spnSegundoApellido").empty();
	$("#spnPrenombres").empty();
	$("#spnAlias").empty();
	$("#spnSexo").empty();
	$("#spnFecNac").empty();
	$("#spnDepartamentoNacimiento").empty();
	$("#spnProvinciaNacimiento").empty();
	$("#spnDistritoNacimiento").empty();
	$("#spnGradoInstruccion").empty();
	$("#spnEstadoCivil").empty();
	$("#spnEstatura").empty();
	$("#spnInscripcion").empty();
	$("#spnNombrePadre").empty();
	$("#spnNombreMadre").empty();
	$("#spnEmision").empty();
	$("#spnRestriccion").empty();
	$("#spnDomicilio").empty();
	$("#spnDepartamentoDeNacimiento").empty();
	$("#spnProvinciaDeNacimiento").empty();
	$("#spnDistritoDeNacimiento").empty();
	$("#spnMultasElectorales").empty();
	
	
	$("#spnCodigoUnicoDeIdentificacion").append(sospechoso.codigoUnicoDeIdentificacion);
	$("#spnPrimerApellido").append(sospechoso.primerApellido);
	$("#spnSegundoApellido").append(sospechoso.segundoApellido);
	$("#spnPrenombres").append(sospechoso.preNombres);
	$("#spnAlias").append(sospechoso.alias);
	if(sospechoso.sexo == 'F'){
		$("#spnSexo").append("Femenino");
	}else if(sospechoso.sexo == 'M'){
		$("#spnSexo").append("Masculino");
	}	 			
	
	if(sospechoso.fechaDeNacimiento != null){
		var fec  = sospechoso.fechaDeNacimiento;
		$("#spnFecNac").append(fec.split("-")[2]+"/"+fec.split("-")[1]+"/"+fec.split("-")[0]);
	}else{
		$("#spnFecNac").append('');
	}	
	
	$("#spnDepartamentoNacimiento").append(sospechoso.departamentoDeNacimiento);
	$("#spnProvinciaNacimiento").append(sospechoso.provinciaDeNacimiento);
	$("#spnDistritoNacimiento").append(sospechoso.distritoDeNacimiento);
	$("#spnGradoInstruccion").append(sospechoso.gradoDeInstruccion);
	$("#spnEstadoCivil").append(sospechoso.estadoCivil);
	$("#spnEstatura").append(sospechoso.estatura);
	if(sospechoso.fechaDeInscripcion != null){
		var fec  = sospechoso.fechaDeInscripcion;
		$("#spnInscripcion").append(fec.split("-")[2]+"/"+fec.split("-")[1]+"/"+fec.split("-")[0]);
	}else{
		$("#spnInscripcion").append('');
	}
	$("#spnNombrePadre").append(sospechoso.nombrePadre);
	$("#spnNombreMadre").append(sospechoso.nombreMadre);
	if(sospechoso.fechaDeEmision != null){
		var fec  = sospechoso.fechaDeEmision;
		$("#spnEmision").append(fec.split("-")[2]+"/"+fec.split("-")[1]+"/"+fec.split("-")[0]);
	}else{
		$("#spnEmision").append('');
	}
	$("#spnRestriccion").append(sospechoso.restriccion);
	$("#spnDomicilio").append(sospechoso.domicilio);
	$("#spnDepartamentoDeDomicilio").append(sospechoso.departamentoDeDomicilio)
	$("#spnProvinciaDeDomicilio").append(sospechoso.provinciaDeDomicilio);
	$("#spnDistritoDeDomicilio").append(sospechoso.distritoDeDomicilio);
	$("#spnMultasElectorales").append(sospechoso.multasElectorales);
	//$("#spnFecNac").append(sospechoso.fechaDeNacimiento);
	//$("#spnGradoInstruccion").append(sospechoso.gradoDeInstruccion);
}

$(document).ready(function(){
	$(".datepicker").datepicker({dateFormat: 'dd/mm/yy'});
	//esto es para que los checkbox del editar esten en blanco cuando se carga la pagina
	$("#checkFemenino").prop("checked", false);
	$("#checkMasculino").prop("checked", false);
	
	var idSospechoso = $("#hdnIdSospechoso").text();
	
		$.ajax({
	 		url: 'getSopechoso-'+idSospechoso,
	 		type: 'post',
	 		dataType: 'json',
	 		data: '',
	 		success: function(sospechoso){
	 			init(sospechoso);
	 		}
	 	});
		
		/* validacion para editar */
		$("#formEditarSospechoso").validate({
			rules:{
				txtFecNac: {peruDate: true},
				txtEstatura: {doubleNumber: true},
				txtInscripcion: {peruDate: true},
				txtEmision: {peruDate: true},
				txtCodUnico: {number: true, minlength: 8, maxlength: 8}
			},
			messages:{
				txtFecNac: "Debe tener formato de fecha dd/mm/aaaa",
				txtEstatura: "Solo N�meros",
				txtInscripcion: "Debe tener formato de fecha dd/mm/aaaa",
				txtEmision: "Debe tener formato de fecha dd/mm/aaaa",
				txtCodUnico: "Solo N�meros, 8 digitos"
			},
			submitHandler: function(form){
				//Se usa 1000-12-12 para que pase de la vista al controlador
				//y en el implements se seteara como null.
				if($("#txtFecNac").val() == ''){
					$("#hdnFecNac").val('1000-12-12');
				}
				
				if($("#txtInscripcion").val() == ''){
					$("#hdnFecIns").val('1000-12-12');
				}
				
				/*$("#hdnEstatura").val($("#txtEstatura").val());*/
				$("#hdnCodUnico").val($("#txtCodUnico").val());
				
				if($("#txtEmision").val() == ''){
					$("#hdnFecEmi").val('1000-12-12');
				}
				//$("#hdnFecEmi").val($("#txtEmision").val());

				$.ajax({
			 		url: 'editarSopechoso',
			 		type: 'post',
			 		dataType: 'json',
			 		data: $("#formEditarSospechoso").serialize(),
			 		success: function(sospechoso){
			 			init(sospechoso);
			 			$("#divMostrarSospechoso").show();
			 			$("#divEditarSospechoso").hide();
			 		}
			 	});
			}
		});
});

$(document).on('change','#txtFecNac', function(e){
	if($("#txtFecNac").val() != null){
		var fec  = $("#txtFecNac").val();
		$("#hdnFecNac").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

$(document).on('change','#txtEmision', function(e){
	if($("#txtInscripcion").val() != null){
		var fec  = $("#txtInscripcion").val();
		$("#hdnFecIns").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

$(document).on('change','#txtEmision', function(e){
	if($("#txtEmision").val() != null){
		var fec  = $("#txtEmision").val();
		$("#hdnFecEmi").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

$(document).on('click','#btnEditarSopechoso', function(e){
	$("#txtCodUnico").val($("#spnCodigoUnicoDeIdentificacion").text());
	$("#txtPrimerApellido").val($("#spnPrimerApellido").text());
	$("#txtSegundoApellido").val($("#spnSegundoApellido").text());
	$("#txtPrenombres").val($("#spnPrenombres").text());
	$("#txtAlias").val($("#spnAlias").text());
	
	if($("#spnSexo").text() == 'Masculino'){
		$("#checkMasculino").prop("checked",true);
	}else if($("#spnSexo").text() == 'Femenino'){
		$("#checkFemenino").prop("checked",true);
	}
	
	$("#txtFecNac").val($("#spnFecNac").text());
	$("#txtDepartamentoDeNacimiento").val($("#spnDepartamentoNacimiento").text());
	$("#txtProvinciaDeNacimiento").val($("#spnProvinciaNacimiento").text());
	$("#txtDistritoDeNacimiento").val($("#spnDistritoNacimiento").text());
	$("#selectGradoInstruccion").val($("#spnGradoInstruccion").text());
	$("#sltcEstadoCivil").val($("#spnEstadoCivil").text());
	$("#txtEstatura").val($("#spnEstatura").text());
	$("#txtInscripcion").val($("#spnInscripcion").text());
	$("#txtNombrePadre").val($("#spnNombrePadre").text());
	$("#txtNombreMadre").val($("#spnNombreMadre").text());
	$("#txtEmision").val($("#spnEmision").text());
	$("#txtRestriccion").val($("#spnRestriccion").text());
	$("#txtDomicilio").val($("#spnDomicilio").text());
	$("#txtDepartamentoDeDomicilio").val($("#spnDepartamentoDeDomicilio").text());
	$("#txtProvinciaDeDomicilio").val($("#spnProvinciaDeDomicilio").text());
	$("#txtDistritoDeDomicilio").val($("#spnDistritoDeDomicilio").text());
	$("#txtMultasElectorales").val($("#spnMultasElectorales").text());
	/// ID SOSPECHOSO en ventana
	$("#hdnIdSospechosoEdit").val($("#hdnIdSospechoso").text());
	// LOS TABS
	$("#divMostrarSospechoso").hide();
	$("#divEditarSospechoso").show();
});

$(document).on('click','#btnCancelEditar', function(e){
	$("#divMostrarSospechoso").show();
	$("#divEditarSospechoso").hide();
});
</script>
<div id="divMostrarDatosSospechoso">
	<div id="divMostrarSospechoso">
		<form:form class="form-horizontal">
	       	<legend>
		       	<span class=""><span class="colored">///</span> Datos del Sospechoso:</span>
		       	<span class="offset3"><button class="btn btn-primary" type="button" id="btnEditarSopechoso"><i class="icon-edit"></i> Editar</button></span>
	       	</legend>
	       		<div class="control-group">
	          		<label class="control-label">C.U.I: </label>
	          		<div class="controls">
	          			<span id="spnCodigoUnicoDeIdentificacion">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Apellidos: </label>
	          		<div class="controls">
	          			<span id="spnPrimerApellido">&nbsp;</span>&nbsp;&nbsp;<span id="spnSegundoApellido">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Prenombres: </label>
	          		<div class="controls">
	          			<span id="spnPrenombres">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Alias: </label>
	          		<div class="controls">
	          			<span id="spnAlias">&nbsp;</span>
	          		</div>
	       		</div>
	       		<div class="control-group">
	          		<label class="control-label">Sexo: </label>
	          		<div class="controls">
	          			<span id="spnSexo">&nbsp;</span>
	          		</div>
	       		</div> 
	       		<div class="control-group">
	          		<label class="control-label">Fecha de Nacimiento: </label>
	          		<div class="controls">
	          			<span id="spnFecNac">&nbsp;</span>
	          		</div>
	       		</div> 
	       		<!--  agregado INICIA-->      
	       		<div class="control-group">
	       			<label class="control-label">Departamento de Nacimiento: </label>
	       			<div class="controls">
	       				<span  id="spnDepartamentoNacimiento"></span>
		          	</div>
		       	</div>
		       	<div class="control-group">
		       		<label class="control-label">Provincia de Nacimiento: </label>
		       			<div class="controls">
		       				<span  id="spnProvinciaNacimiento"></span>
		       			</div>
		       	</div>
		       	<div class="control-group">
		       		<label class="control-label">Distrito de Nacimiento: </label>
		       			<div class="controls">
		       				<span  id="spnDistritoNacimiento"></span>
		       			</div>
		       	</div>
		       	<div class="control-group">
		       		<label class="control-label">Grado de Instrucci�n: </label>
		       			<div class="controls">
		       				<span  id="spnGradoInstruccion"></span>
		          		</div>
		       	</div>
		       	<div class="control-group" id="divGrado">
		       			<label class="control-label">Estado Civil: </label>
		          			<div class="controls">
		          				<span  id="spnEstadoCivil"></span>
		          		</div>
		       	</div>
		       	<div class="control-group">
		          		<label class="control-label">Estatura: </label>
		          		<div class="controls">
		          			<span id="spnEstatura"></span>
		          		</div>
		       	</div>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Inscripci�n: </label>
		          		<div class="controls">
		          			<span id="spnInscripcion"></span>
		          		</div>
		       	</div>
		       	<div class="control-group">
		          		<label class="control-label">Nombre del Padre: </label>
		          		<div class="controls">
		          			<span id="spnNombrePadre"></span>
		          		</div>
		       	</div>
		       		<div class="control-group">
		          		<label class="control-label">Nombre de la Madre: </label>
		          		<div class="controls">
		          			<span id="spnNombreMadre"></span>
		          		</div>
		       		</div>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Emisi�n: </label>
		          		<div class="controls">
		          			<span id="spnEmision"></span>
		          		</div>
		       		</div>
		       		<div class="control-group">
		          		<label class="control-label">Restricci�n: </label>
		          		<div class="controls">
		          			<span id="spnRestriccion"></span>
		          		</div>
		       		</div>
		       		<div class="control-group">
		          		<label class="control-label">Domicilio: </label>
		          		<div class="controls">
		          			<span id="spnDomicilio"></span>
		          		</div>
		       		</div>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Domicilio: </label>
		          		<div class="controls">
		          			<span id="spnDepartamentoDeDomicilio"></span>
		          		</div>
		       		</div>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Domicilio: </label>
		          		<div class="controls">
		          			<span id="spnProvinciaDeDomicilio"></span>
		          		</div>
		       		</div>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Domicilio: </label>
		          		<div class="controls">
		          			<span id="spnDistritoDeDomicilio"></span>
		          		</div>
		       		</div>
		       		<div class="control-group">
		          		<label class="control-label">Multas Electorales: </label>
		          		<div class="controls">
		          			<span id="spnMultasElectorales"></span>
		          		</div>
		       		</div>
	       		<!-- agregado cierre -->
		</form:form>
	</div>
		
	<!-- <section> Formulario editar-->
		<fieldset class="well" style="display: none;" id="divEditarSospechoso">
			<form:form class="form-horizontal" id="formEditarSospechoso" action="editarSospechoso" commandName="sospechoso">
		       	<legend>
			       	<span class="colored">///</span> Editar Datos Personales del Sospechoso:
		       	</legend>
		       		<input type="hidden" name="idSospechoso" id="hdnIdSospechosoEdit">
		       		<div class="control-group">
		          		<label class="control-label">C�digo �nico de Identificaci�n: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtCodUnico" id="txtCodUnico">
		          			<input class="span2" type="hidden" name="codigoUnicoDeIdentificacion" id="hdnCodUnico">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Primer Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtPrimerApellido" name="primerApellido">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Segundo Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtSegundoApellido" name="segundoApellido">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Prenombres: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtPrenombres" name="preNombres">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Alias: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" id="txtAlias" name="alias" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Sexo: </label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="sexo" id="checkMasculino" value="M">Masculino
		          		</label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="sexo" id="checkFemenino" value="F">Femenino
		          		</label>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2 datepicker" type="text" name="txtFecNac" id="txtFecNac">
		          			<input class="span2" type="hidden" name="fechaDeNacimiento" id="hdnFecNac">
		          		</div>
		       		</div>
		       		<!--  -->
		       		<!-- Aqui empieza mario-->
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDepartamentoNacimiento" id="txtDepartamentoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtProvinciaNacimiento" id="txtProvinciaDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDistritoNacimiento" id="txtDistritoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Grado de Instrucci�n: </label>
		          		<div class="controls">
		          			<select class="span2" name="gradoDeInstruccion" id="selectGradoInstruccion">
		          				<option value="">No Precisa</option>
		          				<option>Preescolar</option>
		          				<option>Primaria</option>
		          				<option>Secundaria</option>
		          				<option>Superior</option>
				            </select>
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group" id="divGrado">
		          		<label class="control-label">Estado Civil: </label>
		          		<div class="controls">
		          			<select class="span2" name="estadoCivil" id="sltcEstadoCivil">
		          				<option value="">No Precisa</option>
		          				<option>Casado</option>
		          				<option>Divorciado</option>
		          				<option>Soltero</option>
		          				<option>Viudo</option>
				            </select>
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Estatura: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtEstatura" id="txtEstatura">
		          			<input class="span2" type="hidden" name="estatura" id="hdnEstatura">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Inscripci�n: </label>
		          		<div class="controls">
		          			<input class="span2 datepicker" type="text" name="txtInscripcion" id="txtInscripcion">
		          			<input class="span2" type="hidden" name="fechaDeInscripcion" id="hdnFecIns">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Nombre del Padre: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtNombrePadre" id="txtNombrePadre">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Nombre de la Madre: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtNombreMadre" id="txtNombreMadre">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Fecha de Emisi�n: </label>
		          		<div class="controls">
		          			<input class="span2 datepicker" type="text" name="txtEmision" id="txtEmision">
		          			<input class="span2" type="hidden" name="fechaDeEmision" id="hdnFecEmi">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Restricci�n: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtRestriccion" id="txtRestriccion">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDomicilio" id="txtDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDepartamentoDeDomicilio" id="txtDepartamentoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtProvinciaDeDomicilio" id="txtProvinciaDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtDistritoDeDomicilio" id="txtDistritoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Multas Electorales: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtMultasElectorales" id="txtMultasElectorales">
		          		</div>
		       		</div>
		       		<!-- Aqui cierra mario-->
		       		<div class="form-actions">
			        	<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar Sospechoso</button>
			        	<button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
			        	<button class="btn btn-warning" type="button" id="btnCancelEditar"><i class="icon-arrow-left icon-white"></i> Cancel</button>
			        </div>  
			</form:form>
		</fieldset>
	<!-- </section> -->
</div>

