<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Clientes</title>

    <link href="css/estilos.css" rel="stylesheet">
    
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-theme.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="css/sb-admin-2/metisMenu.min.css" rel="stylesheet">

    <!-- Timeline CSS -->
    <link href="css/sb-admin-2/timeline.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/sb-admin-2/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- DataTables -->
    <link rel="stylesheet" href="css/dataTables/dataTables.bootstrap.min.css">        
    <link rel="stylesheet" type="text/css" href="css/dataTables/buttons.bootstrap.min.css"/>
    
    <!-- jquery Confirm -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.2.3/jquery-confirm.min.css">        

    <!-- Alertify Version Antigua
    <link rel="stylesheet" href="css/alertify/alertify.core.css">
    <link rel="stylesheet" href="css/alertify/alertify.default.css">
    -->
    <!-- Alertify Version Nueva-->
    <link rel="stylesheet" href="css/alertify/alertify.css">    
    <link rel="stylesheet" href="css/alertify/themes/bootstrap.min.css" />
    
    <!-- Animate -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        @font-face {
            font-family: EnterSans;
            src: url(entsans.ttf);
        }
        body{
            font-family: Ebrima;
        }
        .navbar-brand{
            font-family: EnterSans;
        }
    </style>
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <jsp:include page="sidebar2.jsp"></jsp:include>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header" style="margin-top: 10px; margin-bottom: 10px; padding-bottom: 0px;">Clientes</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div id="divMensaje" class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="display: none;"></div>
                <div class="row">                
                    <div id="divtablaClientes" class="col-md-12">        			
                        <div class="table-responsive">
                            <table id="tablaClientes" class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>NIT</th>
                                        <th>NOMBRE</th>
                                        <th>ACCIONES</th>
                                    </tr>
                                </thead>
                                <tbody id="employee_data">
                                </tbody>
                            </table>
                        </div>
                    </div>        		
                </div>
            </div>
            
        </div>
        <!-- /#page-wrapper -->
        
        <!-- Modales -->
        <div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="modalEliminarLabel">
            <div class="modal-dialog" role="document">                            
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="modalEliminarLabel">Eliminar cliente</h4>
                    </div>
                    <div class="modal-body">
                        Â¿EstÃ¡ seguro de eliminar al cliente?<strong data-name=""></strong>
                        <form id="frmEliminarUsuario" action="" method="POST">
                        <input type="hidden" id="idcliente" name="idcliente" value="">
                        <input type="hidden" id="action" name="action" value="eliminar">                        
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="eliminarCliente" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    </div>
                </div>                
            </div>
        </div>
        <!-- Modales -->
        <div class="modal fade" id="modalAgregarCliente" tabindex="-1" role="dialog" aria-labelledby="modalEliminarLabel">
            <div class="modal-dialog" role="document">                                            
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="modalEliminarLabel">Registrar Nuevo cliente</h4>
                    </div>
                    <div class="modal-body">
                        <form id="formClientes" class="form-horizontal" action="" method="POST">
                            <input type="hidden" id="idcliente" name="idcliente" value="0">
                            <input type="hidden" id="action" name="action" value="registrar">
                            <div class="form-group">
                                <label for="nombre" class="col-sm-2 control-label">Nombre</label>
                                <div class="col-sm-8"><input id="nombre" name="nombre" type="text" class="form-control" autofocus></div>
                            </div>
                            <div class="form-group">
                                <label for="nit" class="col-sm-2 control-label">NIT:</label>
                                <div class="col-sm-8"><input id="nit" name="nit" type="text" class="form-control" ></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-8">
                                    <input id="btnGuardar" type="submit" class="btn btn-primary" value="Guardar">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancelar" onclick="$('#formClientes')[0].reset();">Cancelar</button>
                        <hr style="margin-top: 15px;margin-bottom: 15px;">
                        <div class="divError"></div>
                    </div>
                </div>                 
            </div>
        </div>
        
    </div>
    <!-- /#wrapper -->

    <!-- Script -->
    <script src="js/script.js"></script>
        
    <!-- jQuery -->
    <script src="js/jquery-3.2.1.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2/sb-admin-2.js"></script>

    <script type="text/javascript" src="js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/dataTables/dataTables.bootstrap.min.js"></script>

    <script type="text/javascript" src="js/dataTables/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="js/dataTables/buttons.bootstrap.min.js"></script>

    <script type="text/javascript" src="js/dataTables/buttons.html5.min.js"></script>

    <script type="text/javascript" src="js/dataTables/jszip.min.js"></script>
    <script type="text/javascript" src="js/dataTables/pdfmake.min.js"></script>
    <script type="text/javascript" src="js/dataTables/vfs_fonts.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.2.3/jquery-confirm.min.js"></script>
    <!-- Alertas Version Antigua 
    <script src="js/alertify/alertify.min.js"></script>
    -->
    <!-- Alertas Version Nueva -->
    <script src="js/alertify/alertify.js"></script>
    <script>
        $(document).ready(function(){
            alertify.defaults.transition = "slide";
            alertify.defaults.theme.ok = "btn btn-primary";
            alertify.defaults.theme.cancel = "btn btn-danger";
            alertify.defaults.theme.input = "form-control";            
        
            var dataTable = $('#tablaClientes').DataTable({
                "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todos"]],
                destroy: true,
                responsive: true,
                "order":[[1,'asc']],
                ajax:{
                    method: "POST",
                    url: "listarclientes2",                            
                    dataSrc: "data"
                },
                columns:[
                    {"data":"nit"},
                    {"data":"nombre"},
                    {"data":"acciones"}
                ],
                dom: '<"row"<"col-xs-12 col-sm-4 col-md-4"l><"col-xs-12 col-sm-4 col-md-4"B><"col-xs-12 col-sm-4 col-md-4"f>>'+
                     'tr<"row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>> ',
                'columnDefs': [
                    {
                        'targets': [0,1],
                        'createdCell':  function (td, cellData, rowData, row, col) {
                            $(td).attr('contenteditable', 'true');
                        }
                    }
                ],
                buttons: [                          
                    {
                        extend:    'copy',
                        text:      '<img src="images/icons/copiar.png" alt="Copiar">',
                        className: 'btn btn-default btn-sm',
                        titleAttr: 'Copiar todos los registros'
                    },
                    {
                        extend:    'excel',
                        text:      '<img src="images/icons/excel.png" alt="Excel">',
                        className: 'btn btn-default btn-sm',
                        titleAttr: 'Exportar a excel'
                    },
                    {
                        extend:    'pdf',
                        text:      '<img src="images/icons/pdf.png" alt="Excel">',
                        className: 'btn btn-default btn-sm',
                        titleAttr: 'Exportar a PDF'
                    },
                    {
                        "text": "<span class='glyphicon glyphicon-plus'></span>",
                        "titleAttr": "Nuevo",
                        className: 'btn btn-default btn-sm',
                        "action": function(){
                            $('#formClientes #action').val('registrar');
                            $('#modalAgregarCliente .modal-title').text('Registrar cliente');
                            $('#modalAgregarCliente').modal('show');
                            $('.divError').empty();
                        }
                    },
                    {
                        "text": "<span class='glyphicon glyphicon-refresh'></span>",
                        "titleAttr": "Recargar tabla",
                        className: 'btn btn-default btn-sm',
                        "action": function(){
                            dataTable.ajax.reload();
                        }
                    }
                ],
                language: {
                    "url":"espanol.txt"
                }
            });
            
            $('#divtablaClientes').addClass('fadeInUpBig animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
                $('#divtablaClientes').removeClass('fadeInUpBig animated');
            });
            
            $("#formClientes").submit(function(event){
                event.preventDefault();
                if($('#nombre').val()===''||$('#nombre').val()===null){
                    $('#nombre').parent().addClass('has-error');
                    $('#nombre').parent().addClass('wobble animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
                        $('#nombre').parent().removeClass('wobble animated');//.addClass('form-control');
                    });
                    return;
                }
                var frm = $(this).serialize();
                $.ajax({
                    method: "POST",
                    url: "registrarCliente",
                    data: frm
                }).done(function(data){
                    var obj = jQuery.parseJSON(data);                                        
                    if(obj.mensaje.indexOf('ERROR')!==-1){
                        $('#modalAgregarCliente .modal-footer .divError').html(obj.html);                        
                        $('#modalAgregarCliente .modal-footer .divError').addClass('tada animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
                            $('#modalAgregarCliente .modal-footer .divError').removeClass('tada animated');
                            //alertify.dialog('alert').set({transition:'flipy', title: obj.mensaje, message: obj.html}).show();
                        });                        
                    }else{
                        //alertify.success(obj.mensaje);
                        $('#formClientes')[0].reset();
                        $('#modalAgregarCliente').modal('hide');
                        dataTable.ajax.reload();
                        $('#tablaClientes').addClass('fadeInUpBig animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
                            $('#tablaClientes').removeClass('fadeInUpBig animated');
                            //alertify.dialog('alert').set({transition:'flipy', title: obj.mensaje, message: obj.html}).show();
                        });
                    }                                    
                });
            });
            
            $(document).on('click', '.actualizar', function(){
                var idcliente = $(this).attr('id');
                var row = $(this).parent().parent();
                $.ajax({
                    url: "buscarcliente.do",
                    method: "POST",
                    data: {"idcliente":idcliente},
                    success: function(data){
                        var obj = jQuery.parseJSON(data);
                        $('#formClientes #action').val('editar');
                        $('#formClientes #nombre').val(obj.nombreCliente);
                        $('#formClientes #nit').val(obj.nitCliente);
                        $('.modal-title').text('Actualizar datos');
                        $('#modalAgregarCliente').modal('show');
                    },
                    error: function(error){
                        alertify.error('ERROR AL EJECUTAR EL PROCEDIMIENTO AJAX.'); 
                    }
                }).done();
            });
            
            $(document).on('click', '.eliminar', function(){
                var idcliente = $(this).attr('id');
                var row = $(this).parent().parent();
                alertify.confirm(
                    'Confirmar accion', 'Desea borrar el cliente de la base de datos?', 
                    function(){
                        $.ajax({
                            url: "registrarCliente",
                            method: "POST",
                            data: {"action":"eliminar","idcliente":idcliente},
                            success: function(data){
                                var obj = jQuery.parseJSON(data);                                        
                                if(obj.mensaje.indexOf('ERROR')!==-1){
                                    alertify.dialog('alert').set({transition:'flipy', title: obj.mensaje, message: obj.html}).show();
                                }else{
                                    row.addClass('zoomOut animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
                                        row.parent().removeClass('zoomOut animated');//.addClass('form-control');
                                        row.remove();
                                    });
                                    //alertify.success(obj.mensaje);
                                    //row.fadeOut(1000);
                                }
                            },
                            error: function(error){
                                alertify.error('ERROR AL EJECUTAR EL PROCEDIMIENTO AJAX.'); 
                            }
                        });
                    }, 
                    function(){}
                ).set({transition:'flipy',}
                );
            });
            var valor = null;
            $(document).on('focus', '#tablaClientes tbody tr td', function(){
                valor = $(this).text();
            });
            $(document).on('blur', '#tablaClientes tbody tr td', function(){
                var newVal = $(this).text();                    
                var column_name, col = $(this).index();
                var celda = $(this);
                switch(col){
                    case 0: column_name = 'nitcliente';break;
                    case 1: column_name = 'nombrecliente';break;
                }
                var idcliente = $($(this).parent()).find('td:eq(2)').find('button.eliminar').attr('id');
                if(newVal !== valor){
                    $.ajax({
                        url:"registrarCliente",  
                        method:"POST",  
                        data:{"action":"editar", "idcliente":idcliente, "text":newVal, "column_name":column_name},
                        success:function(data){  
                            celda.css({
                                'background-color': '#5fba7d',
                                '-webkit-transition': 'background-color 2s ease-out',
                                '-moz-transition': 'background-color 2s ease-out',
                                'transition': 'background-color 2s ease-out'
                            });                                
                            setTimeout(function(){
                                celda.css("background-color", "");
                            }, 2000);                                
                        },
                        error: function(error){
                            alert('ERROR '+error);
                        }
                    });
                }                    
            });
        });
    </script>
</body>

</html>
