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
        <jsp:include page="sidebar2.jsp"></jsp:include>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header" style="margin-top: 10px; margin-bottom: 10px; padding-bottom: 0px;">Control de transformadores</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div id="divMensaje" class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="display: none;"></div>
                <div class="row">                
                    <div id="divTablaControlTotal" class="col-md-12">        			
                        <div class="table-responsive">
                            <table id="TablaControlTotal" class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ITEM</th>
                                        <th>CLIENTE</th>
                                        <th>LOTE</th>
                                        <th>F. RECEPCION</th>
                                        <th>CIUDAD</th>
                                        <th>CONDUCTOR</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>        		
                </div>
            </div>                        
            
        </div>
        <!-- /#page-wrapper -->      
        
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
        var dataTable;
        var rowSelected;
        $(document).ready(function(){
                       
            alertify.defaults.transition = "slide";
            alertify.defaults.theme.ok = "btn btn-primary";
            alertify.defaults.theme.cancel = "btn btn-danger";
            alertify.defaults.theme.input = "form-control";
            
            dataTable = $('#TablaControlTotal').DataTable({
                "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todos"]],
                "scrollX": true,
                destroy: true,
                responsive: true,
                "order":[[1,'asc']],
                ajax:{
                    method: "POST",
                    url: "controltotal",
                    dataSrc: "data"
                },
                columns:[
                    {"data":"identrada"},
                    {"data":"nombrecliente"},
                    {"data":"lote"},
                    {"data":"numeroempresa"},
                    {"data":"fase"},
                    {"data":"marca"}
                ],
                dom: '<"row"<"col-xs-12 col-sm-4 col-md-4"l><"col-xs-12 col-sm-4 col-md-4"B><"col-xs-12 col-sm-4 col-md-4"f>>'+
                     'tr<"row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>> ',
                buttons: [
                    {
                        "text": "<span class='glyphicon glyphicon-refresh' aria-hidden='true'></span>",
                        "titleAttr": "Recargar tabla", "className": 'btn btn-default btn-xs',
                        "action": function(){dataTable.ajax.reload();}
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
                        
            $('#divTablaControlTotal').addClass('fadeInUpBig animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
                $('#divTablaControlTotal').removeClass('fadeInUpBig animated');
            });
                        
            $(document).on('click', '#TablaControlTotal tbody tr td', function(){
                rowSelected = $(this).parent();
            });                                                      

        });
    </script>
</body>

</html>
