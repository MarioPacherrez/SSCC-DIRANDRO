<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="utf-8">
<title>SSCC - DIRANDRO - Crear Sospechoso</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- para que funcione el jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<!-- para que funcione el jquery de la plantilla -->
<script src="js/jquery.js"></script>
<!-- datepicker librerias -->
<script src="js/jquery-ui.js"></script>
<link href="css/smoothness/jquery-ui.css" rel="stylesheet">
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css"> -->
<!-- para el menu -->
<script src="js/bootstrap-collapse.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/validateFecha.js"></script>
<!-- alertas de colores -->
<script src="js/bootstrap-alert.js"></script>
<!-- styles -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/docs.css" rel="stylesheet">
<link href="js/google-code-prettify/prettify.css" rel="stylesheet">
<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
<style>
.error{
	color: rgb(255, 0, 0);
}
</style>
<script>
$(document).on('change','#txtFecNac', function(e){
	if($("#txtFecNac").val() != ''){
		var fec = $("#txtFecNac").val();
		$("#hdnFecNac").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});
$(document).on('change','#txtInscripcion', function(e){
	if($("#txtInscripcion").val() != ''){
		var fec = $("#txtInscripcion").val();
		$("#hdnFecIns").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});
$(document).on('change','#txtEmision', function(e){
	if($("#txtEmision").val() != ''){
		var fec = $("#txtEmision").val();
		$("#hdnFecEmi").val(fec.split("/")[2]+"-"+fec.split("/")[1]+"-"+fec.split("/")[0]);		
	}
});

var flag = false;
var flag2 = false;
$(document).ready(function() {
	$( ".datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
	
	$("#formCrearSospechoso").validate({
		rules:{
			txtFecNac: {peruDate: true},
			txtEstatura: {doubleNumber: true},
			txtInscripcion: {peruDate: true},
			txtEmision: {peruDate: true},
			txtCodUnico: {number: true, minlength: 8, maxlength: 8},
			multasElectoraleso:{number:true, maxlength:4}
		},
		messages:{
			txtFecNac: "Debe tener formato de fecha dd/mm/aaaa",
			txtEstatura: "Solo N�meros",
			txtInscripcion: "Debe tener formato de fecha dd/mm/aaaa",
			txtEmision: "Debe tener formato de fecha dd/mm/aaaa",
			multasElectoraleso:"S�lo N�meros",
			txtCodUnico: "S�lo N�meros, 8 digitos",
			txtCodUnico: "C�digo �nico de Identificaci�n ya existes."
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
			
			$("#hdnEstatura").val($("#txtEstatura").val());
			$("#hdnCodUnico").val($("#txtCodUnico").val());
			
			if($("#txtEmision").val() == ''){
				$("#hdnFecEmi").val('1000-12-12');
			}
			if(flag == true && flag2 == true){
				form.submit();
			}else if($("#txtCodUnico").val() == ''){
				form.submit();
			}else{
				alert("Debe Corregir los datos");
			}			
		}
	});
});
$(document).on('change','#txtAlias', function(e){
	$.ajax({
		url: 'getAlias-'+$('#txtAlias').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(sospechoso){
			if(sospechoso == true){
				$("#alertasSospechosoNuevo").show();
				$("#alertasSospechosoNuevo").empty();
				$("#alertasSospechosoNuevo").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">�</a>'+
	 			        '<strong id="msgVerde">El Alias usado ya existe en otro sospechoso.</strong>'+
	 			    '</div>');
				flag = false;
			}else{
				flag = true;
			}
		}
	});
});
$(document).on('change','#txtCodUnico', function(e){
	$.ajax({
		url: 'getCUI-'+$('#txtCodUnico').val(),
		type: 'post',
		dataType: 'json',
		data: '',
		success: function(sospechoso){
			if(sospechoso == true){
				$("#alertasSospechosoNuevo2").show();
				$("#alertasSospechosoNuevo2").empty();
				$("#alertasSospechosoNuevo2").append('<div class="alert alert-error" id="alertaVerde">'+
	 			        '<a class="close" data-dismiss="alert">�</a>'+
	 			        '<strong id="msgVerde">El C�digo �nico de Identificaci�n usado ya existe en otro sospechoso.</strong>'+
	 			    '</div>');
				flag2 = false;
			}else{
				flag2 = true;
			}
		}
	});
});
</script>
</head>
<body>
<!--HEADER-->
<jsp:include page="../componentes/header.jsp"/>
<!--/HEADER-->
<!--CENTRO-->
<!--MENU-->
<jsp:include page="../componentes/menu.jsp"/>
<!--/MENU-->
<div class="container inner_content">
	<section class="span9" style="margin-left: 80px;">
		<fieldset class="well">
		<div id="alertasSospechosoNuevo" style="display: none;">
		</div>
		<div id="alertasSospechosoNuevo2" style="display: none;">
		</div>
			<form:form class="form-horizontal" id="formCrearSospechoso" action="crearSospechoso" commandName="sospechoso">
		       	<legend><span class="colored">///</span> Datos Personales del Sospechoso:</legend>
		       	<div class="span4">
		       		<div class="control-group">
		          		<label class="control-label" title="C�digo �nico de Identificaci�n">C.U.I: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="txtCodUnico" id="txtCodUnico">
		          			<input class="span2" type="hidden" name="codigoUnicoDeIdentificacion" id="hdnCodUnico">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Primer Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="primerApellido">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Segundo Apellido: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="segundoApellido">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Prenombres: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="preNombres">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Alias: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="alias" id="txtAlias" data-rule-required="true" data-msg-required="*">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Sexo: </label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="sexo" id="" value="M">Masculino
		          		</label>
		          		<label class="checkbox inline">
		          			<input type="radio" name="sexo" id="" value="F">Femenino
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
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="departamentoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="provinciaDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Nacimiento: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="distritoDeNacimiento">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Grado de Instrucci�n: </label>
		          		<div class="controls">
		          			<select class="span2" name="gradoDeInstruccion">
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
		       	</div>
		       	<div class="span4">
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
		          			<input class="span2" type="text" name="nombrePadre">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Nombre de la Madre: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="nombreMadre">
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
		          			<input class="span2" type="text" name="restriccion">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="domicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Departamento de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="departamentoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Provincia de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="provinciaDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Distrito de Domicilio: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="distritoDeDomicilio">
		          		</div>
		       		</div>
		       		<hr>
		       		<div class="control-group">
		          		<label class="control-label">Multas Electorales: </label>
		          		<div class="controls">
		          			<input class="span2" type="text" name="multasElectoraleso">
		          		</div>
		       		</div>
		       	</div>
		       	<span class="span9">
		       		<div class="form-actions">
			        	<button class="btn btn-success" id="btnGuardar" type="submit"><i class="icon-ok icon-white"></i> Guardar Sospechoso</button>
			        	<button class="btn btn-danger" type="reset"><i class="icon-refresh icon-white"></i> Reset</button>
			        </div> 
		       	</span>	
		       		 
			</form:form>
		</fieldset>
	</section>
</div>
<!--/CENTRO-->
<!-- sticky footer -->
<jsp:include page="../componentes/footer.jsp"/>
<!-- /sticky footer -->
</body>
</html>