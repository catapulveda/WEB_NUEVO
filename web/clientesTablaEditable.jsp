<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="clases.PoolConexiones"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Clientes 1</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">        
                
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/jquery-confirm.min.css"/>
        <link rel="stylesheet" href="css/alertify/alertify.core.css" id="toggleCSS" />
        <link rel="stylesheet" href="css/alertify/alertify.default.css" id="toggleCSS" />
        <link rel="stylesheet" type="text/css" href="css/dialogosModales/custombox.min.css">
        <style>
            td {                
                white-space: nowrap;
            }   
            #tablaClientes {
                font-family: Ebrima;
                font-size: 12px;
            }
            #tablaClientes button{
                padding: 3px;
            }
        </style>
        
    </head>
    <body>
        <div class="container-fluid">
            <br>
            <div class="row">
                <div class="col-md-3">
                    <form class="form-group-xs" role="form" id="formRegistrarCliente" onsubmit="insertarCliente(); return false;">
                        <h4>Registrar cliente</h4>
                    
                        <div class="form-group">
                            <label for="nombrecliente" class="control-label col-sm-2">Nombre:</label>
                            <input id="ciudad" name="nombrecliente" class="form-control" type="text" placeholder="Ingrese el nombre del cliente">
                        </div>
                    
                        <div class="form-group">
                            <label for="nit" class="control-label col-sm-2">NIT:</label>
                            <input id="conductor" name="nit" class="form-control" type="text" placeholder="Ingrese el nit">
                        </div>                    
                    
                        <div class="form-group">
                            <input  value="Registrar" type="submit" class="btn btn-primary btn-sm">
                        </div>
                    </form>
                </div>
                <div class="col-md-9">
                    <a href="clientes2.html" id="example5">Abrir</a>
                    <div class="table-responsive">
                        <table id="tablaClientes" class="tabledit-form table table-striped table-bordered table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th>ITEM</th>
                                    <th>NOMBRE</th>
                                    <th>NIT</th>
                                </tr>
                            </thead>    
                            <tbody>
                                <%
                                    String sql = "SELECT * FROM cliente ORDER BY nombrecliente";
                                    DataSource source = PoolConexiones.PoolConexiones();                    
                                    Connection con = source.getConnection();
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery(sql);
                                    while(rs.next()){
                                        out.print("<tr>");
                                        out.print("<td class='text-center'>"+rs.getInt("idcliente")+"</td>");
                                        out.print("<td data-id1="+rs.getInt("idcliente")+" >"+rs.getString("nombrecliente")+"</td>");
                                        out.print("<td data-id2="+rs.getInt("idcliente")+" >"+rs.getString("nitcliente")+"</td>");
                                        out.println("</tr>");
                                    }
                                    con.close();
                                    st.close();
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>                            
            </div>
        </div>
        
        <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>        
        <script type="text/javascript" src="js/jquery.tabledit.min.js"></script>
        <script type="text/javascript" src="js/jquery-confirm.min.js"></script>
        <script type="text/javascript" src="js/alertify.min.js"></script>
        <script src="js/dialogosModales/custombox.min.js"></script>
        <script>                                    
            $(document).ready(function(){
                cargarClientes();
                
                alertify.alert("This is an alert dialog");
            });
            
            var cargarClientes = function(){
                var tabla = $('#tablaClientes').Tabledit({
                    inputClass: 'form-control input-sm',
                    toolbarClass: 'btn-toolbar',
                    groupClass: 'btn-group btn-group-sm',
                    dangerClass: 'danger',
                    warningClass: 'warning',
                    mutedClass: 'text-muted',
                    eventType: 'click',
                    rowIdentifier: 'id',
                    hideIdentifier: true,                    
                    editButton: false,
                    deleteButton: true, 
                    saveButton: true,
                    restoreButton: false,
                    buttons:{
                        edit:{
                            class: 'btn btn-sm btn-primary',
                            html: '<span class="glyphicon glyphicon-pencil"></span>',
                            action: 'edit'
                        },
                        delete: {
                            class: 'btn btn-sm btn-default',
                            html: '<span class="glyphicon glyphicon-trash"></span>',
                            action: 'delete'
                        },
                        save: {
                            class: 'btn btn-sm btn-success',
                            html: '<span class="glyphicon glyphicon-ok"></span>'
                        },
                        restore: {
                            class: 'btn btn-sm btn-warning',
                            html: 'Restaurar',
                        },
                        confirm: {
                            class: 'btn btn-md btn-warning',
                            html: '<span class="glyphicon glyphicon-question-sign"></span>'
                        }
                    },
                    columns: {
                        identifier: [0, 'id'],                         
                        editable: [
                            [1, 'nombrecliente'],
                            [2, 'nitcliente']
                        ]
                    },
                    onDraw: function() { 
                        //alert('onDraw');
                    },
                    onSuccess: function(data, textStatus, jqXHR) { 
                        //alert('onSuccess:\n'+data+'\n'+textStatus+'\n'+jqXHR);    
                    },
                    onFail: function(jqXHR, textStatus, errorThrown) { 
                        //alert('Fail:\n'+jqXHR+'\n'+textStatus+'\n'+errorThrown);
                    },
                    onAlways: function() { 
                        //alert('onAlways');                        
                    },
                    onAjax: function(action, serialize){
                        alert(action+'\n'+serialize);
                        $.ajax({
                            type: "POST",
                            url: "registrarCliente",
                            data: serialize,
                            success: function(resp){
                                alert(resp);
                                if(action==='remove'){
                                    //QUITA LA FILA DE TABLA
                                    $('#'+resp).remove();
                                }else if(action==='edit'){
                                    $('#'+resp).addClass('success')
                                }
                            },
                            error: function(error){
                                alert('ERROR EN onAjax '+error);
                            }
                        });
                    }
                });
            };
            
            function insertarCliente(){
                $.ajax({
                    type: "POST",
                    url: "registrarCliente",
                    data: "action=insert&"+$("#formRegistrarCliente").serialize(),
                    async: true,
                    cache: false,
                    success: function(resp){
                        cargarClientes();
                    }
                });
            }                         
        </script>        
        
    </body>
</html>
