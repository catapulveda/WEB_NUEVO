<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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
        *{
            box-sizing: border-box;
        }
        .ok{
            width: 100%;
            height: 100%;
            background: #FFF;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 9999999;
            text-align: center;
        }
    </style>
</head>

<body>
    <div class="preload">
    </div>
        <!-- Navigation -->
        <jsp:include page="sidebar2.jsp"></jsp:include>

        <div id="wrapper">            
        
        <div id="page-wrapper">                        
            
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header" style="margin-top: 10px; margin-bottom: 10px; padding-bottom: 0px;">Control de transformadores</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div id="divMensaje" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="row">                
                    <div id="divTablaControlTotal" class="col-md-12">        			
                        <div class="table-responsive">                            
                            <table id="TablaControlTotal" class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>CLIENTE</th>
                                        <th>LOTE</th>
                                        <th>SERIE</th>
                                        <th>No EMPRESA</th>
                                        <th>FASE</th>
                                        <th>MARCA</th>
                                        <th>KVA</th>
                                        <th>ESTADO</th>
                                        <th>REMISON</th>
                                        <th>DESPACHO</th>
                                        <th>RECEPCION</th>
                                        <th>CIUDAD</th>
                                        <th>CONTRATO</th>
                                        <th>O.P</th>
                                        <th>CENTRO DE COSTOS</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                    <c:catch var="ex">
                                        <sql:query var="rs" dataSource="jdbc/pooldb">
                                            SELECT e.identrada, cli.nombrecliente, e.lote, t.numeroserie,
                                            t.numeroempresa, t.fase, t.marca, t.kvasalida, t.estado, r.numero_remision,
                                            d.nodespacho, e.fecharecepcion, ciu.nombreciudad, e.contrato, e.op, e.centrodecostos
                                            FROM entrada e INNER JOIN transformador t USING(identrada)
                                            INNER JOIN cliente cli USING (idcliente)
                                            INNER JOIN ciudad ciu USING (idciudad) 
                                            LEFT JOIN despacho d USING(iddespacho)
                                            LEFT JOIN remision r USING(idremision)
                                            ORDER BY e.idcliente, e.fecharecepcion
                                        </sql:query>
                                        <c:forEach var="row" items="${rs.rows}">            
                                            <tr>
                                                <td><c:out value="${row.nombrecliente}" /></td>
                                                <td><c:out value="${row.lote}" /></td>
                                                <td><c:out value="${row.numeroserie}" /></td> 
                                                <td><c:out value="${row.numeroempresa}" /></td> 
                                                <td><c:out value="${row.fase}" /></td>
                                                <td><c:out value="${row.marca}" /></td>
                                                <td><c:out value="${row.kvasalida}" /></td> 
                                                <td><c:out value="${row.estado}" /></td> 
                                                <td><c:out value="${row.numero_remision}" /></td>
                                                <td><c:out value="${row.nodespacho}" /></td>
                                                <td><c:out value="${row.fecharecepcion}" /></td> 
                                                <td><c:out value="${row.nombreciudad}" /></td> 
                                                <td><c:out value="${row.contrato}" /></td>
                                                <td><c:out value="${row.op}" /></td>
                                                <td><c:out value="${row.centrodecostos}" /></td> 
                                            </tr>
                                        </c:forEach>
                                    </c:catch>
                                    <c:if test="${ex != null}">
                                        <div class="alert alert-danger">${ex}</div>
                                    </c:if>
                                </tbody>
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
                "processing": true,
                "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todos"]],
                "scrollX": true,
                "destroy": true,
                "responsive": true,
                "order":[[1,'asc']],          
                "deferLoading": 57,
                dom: '<"row"<"col-xs-12 col-sm-4 col-md-4"l><"col-xs-12 col-sm-4 col-md-4"B><"col-xs-12 col-sm-4 col-md-4"f>>'+
                     'tr<"row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>> ',
                buttons: [
                    {
                        "text": "<span class='glyphicon glyphicon-refresh' aria-hidden='true'></span>",
                        "titleAttr": "Recargar tabla", "className": 'btn btn-success btn-xs',
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
