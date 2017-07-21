<jsp:include page="sesion.jsp"></jsp:include>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Lotes</title>

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
    
    <link rel="stylesheet" href="css/dataTables/select.dataTables.min.css">
    
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
        
    </style>
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <jsp:include page="sidebar.jsp"></jsp:include>

        <div id="page-wrapper" style="margin-top: 50px;">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header" style="margin-top: 10px; margin-bottom: 10px; padding-bottom: 0px;">Lotes Registrados</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div id="divMensaje" class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="display: none;"></div>
                <div class="row">                
                    <div id="divTablaLotes" class="col-md-12">        			
                        <div class="table-responsive">
                            <table id="TablaLotes" class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ITEM</th>
                                        <th>CLIENTE</th>
                                        <th>LOTE</th>
                                        <th>F. RECEPCION</th>
                                        <th>CIUDAD</th>
                                        <th>CONDUCTOR</th>
                                        <th># ENTRADA</th>
                                        <th>CONTRATO</th>
                                        <th>O.P</th>
                                        <th>CENTRO DE COSTOS</th>
                                        <th>F. REGISTRO</th>
                                        <th>F. ACTUALIZADO</th>
                                        <th>F. LIBERADO</th>
                                        <th>ESTADO</th>
                                        <th>ELABORADO POR</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>        		
                </div>
            </div>
            
            <div class="row">                
                <div id="divTablaDatosLote" class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="display: none;">        			
                    <div class="table-responsive">
                        <table id="TablaDatosLote" class="table table-bordered table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>ITEM</th>
                                    <th>REMISION</th>
                                    <th>No EMPRESA</th>
                                    <th>No SERIE</th>
                                    <th>MARCA</th>
                                    <th>KVA</th>
                                    <th>FASE</th>
                                    <th>TENSION</th>
                                    <th>A.T</th>
                                    <th>B.T</th>
                                    <th>H.A</th>
                                    <th>H.B</th>
                                    <th>INT</th>
                                    <th>EXT</th>
                                    <th>HERRAJE</th>
                                    <th>AÑO</th>
                                    <th>PESO</th>
                                    <th>ACEITE</th>
                                    <th>OBSERVACION</th>
                                    <th>SERVICIO</th>
                                    <th>TIPO/<th>
                                </tr>
                            </thead>
                        </table>
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
                        <h4 class="modal-title" id="modalEliminarLabel">Eliminar lote</h4>
                    </div>
                    <div class="modal-body">
                        ¿Esta seguro de eliminar el lote?<strong data-name=""></strong>
                        <form id="frmEliminarUsuario" action="" method="POST">
                        <input type="hidden" id="idlote" name="idlote" value="">
                        <input type="hidden" id="action" name="action" value="eliminar">                        
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="eliminarLote" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
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

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/sb-admin-2/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2/sb-admin-2.js"></script>

    <script type="text/javascript" src="js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/dataTables/dataTables.bootstrap.min.js"></script>
    
    <script type="text/javascript" src="js/dataTables/dataTables.select.min.js"></script>

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
        var dataTable, dataTable_DatosLote;
        var rowSelected;
        $(document).ready(function(){
                       
            alertify.defaults.transition = "slide";
            alertify.defaults.theme.ok = "btn btn-primary";
            alertify.defaults.theme.cancel = "btn btn-danger";
            alertify.defaults.theme.input = "form-control";
            
            dataTable = $('#TablaLotes').DataTable({
                "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todos"]],
                "scrollX": true,
                destroy: true,
                responsive: true,
                "order":[[1,'asc']],
                ajax:{
                    method: "POST",
                    url: "listarlotes",
                    dataSrc: "data"
                },
                columns:[
                    {"data":"identrada"},
                    {"data":"cliente"},
                    {"data":"lote"},
                    {"data":"fecharecepcion"},
                    {"data":"ciudad"},
                    {"data":"conductor"},
                    {"data":"identradaalmacen"},
                    {"data":"contrato"},
                    {"data":"op"},
                    {"data":"centrodecostos"},
                    {"data":"fechaderegistro"},
                    {"data":"fechaactualizado"},
                    {"data":"fechaliberado"},
                    {"data":"estado"},
                    {"data":"nombreusuario"}
                ],
                dom: '<"row"<"col-xs-12 col-sm-4 col-md-4"l><"col-xs-12 col-sm-4 col-md-4"B><"col-xs-12 col-sm-4 col-md-4"f>>'+
                     'tr<"row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>> ',
                buttons: [
                    {
                        "text": "<span class='glyphicon glyphicon-refresh' aria-hidden='true'></span>",
                        "titleAttr": "Recargar tabla", "className": 'btn btn-default btn-xs',
                        "action": function(){dataTable.ajax.reload();}
                    },
                    {
                        "text": "<span class='glyphicon glyphicon-eye-open' aria-hidden='true'></span>",
                        "titleAttr": "Ver lote", "className": 'btn btn-default btn-xs',
                        "action": function(){
                            var idlote = rowSelected.find('td:eq(0)').find('button').attr('id');                            
                            abrirLote(idlote);
                        }
                    }
                ],
                language: {
                    "url":"espanol.txt"
                },
                select: {
                    style: 'os',
                    items: 'row'
                }
            });
            
            $('#divTablaLotes').addClass('fadeInUpBig animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
                $('#divTablaLotes').removeClass('fadeInUpBig animated');
            });
                        
            $(document).on('click', '#TablaLotes tbody tr td', function(){
                rowSelected = $(this).parent();
            });
            
            $(document).on('click', '.verLote', function(){
                rowSelected = $(this).parent().parent();
                abrirLote($(this).attr('id'));
            });
                                  
            $(document).on('click', '.eliminar', function(){
                var idcliente = $(this).attr('id');
                var row = $(this).parent().parent();
                alertify.confirm(
                    'Confirmar accion', 'Desea borrar el lote de la base de datos?', 
                    function(){
                        $.ajax({
                            url: "",
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

        });
        
        function abrirLote(idlote){
            $('#divTablaLotes').slideUp('slow');
            dataTable_DatosLote = $('#TablaDatosLote').DataTable({
                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "Todos"]],               
                destroy: true,
                responsive: true,
                ajax: {
                    url: 'abrirlote',
                    type: 'POST',
                    data: {"idlote":idlote,"order":false}
                },
                columns:[
                    {"data":"idtransformador"},
                    {"data":"item"},
                    {"data":"numero_remision"},
                    {"data":"numeroempresa"},
                    {"data":"numeroserie"},
                    {"data":"marca"},
                    {"data":"kvaentrada"},
                    {"data":"fase"},
                    {"data":"tpe"},
                    {"data":"aat"},
                    {"data":"abt"},
                    {"data":"hat"},
                    {"data":"hbt"},
                    {"data":"ci"},
                    {"data":"ce"},
                    {"data":"herraje"},
                    {"data":"ano"},
                    {"data":"peso"},
                    {"data":"aceite"},
                    {"data":"observacionentrada"},
                    {"data":"servicioentrada"},
                    {"data":"tipotrafoentrada"}
                ],
                dom: '<"row"<"col-xs-12 col-sm-4 col-md-4"l><"col-xs-12 col-sm-4 col-md-4"B><"col-xs-12 col-sm-4 col-md-4"f>>'+
                     'tr<"row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>> ',
                buttons: [
                    {
                        "text": "<i class='fa fa-arrow-left' aria-hidden='true'></i>",
                        "titleAttr": "Volver a lotes", "className": 'btn btn-default btn-xs',
                        "action": function(){
                            $('#divTablaDatosLote').slideUp('slow');
                            $('#divTablaLotes').slideDown('slow');                            
                        }
                    }
                ],
                language:{
                    "url":"espanol.txt"
                },
                select:{
                    style: 'os',
                    items: 'row'
                },                
            });
            $('#divTablaDatosLote').slideDown('slow');
        }
    </script>
</body>

</html>
