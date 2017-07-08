<%@page import="clases.Conductor"%>
<%@page import="clases.Ciudad"%>
<%@page import="clases.Cliente"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="clases.PoolConexiones"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs-3.3.7/dt-1.10.15/b-1.3.1/fh-3.1.2/datatables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/rowgroup/1.0.0/css/rowGroup.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">        
        <style>
            td {                
                white-space: nowrap;
            }   
            .dataTables_wrapper {
                font-family: Ebrima;
                font-size: 12px;
            }

            #events {
                margin-bottom: 1em;
                padding: 1em;
                background-color: #f6f6f6;
                border: 1px solid #999;
                border-radius: 3px;
                height: 100px;
                overflow: auto;
            }
        </style>
    </head>
    <body>
        <header>
            
        </header>
        
        <div class="container-fluid">
        	<p>Lotes</p>
            <div class="row">
                <div class="col-lg-12">
                    <div class="table-responsive">
                        <table id="table_id" class="table table-striped table-bordered table-hover table-condensed">                        
                            <thead>
                                <tr class="text-center">
                                    <td>#</td>
                                    <td>CLIENTE</td>
                                    <td>LOTE</td>
                                    <td>FECHA DE RECEPCION</td>
                                    <td>CIUDAD</td>
                                    <td>CONDUCTOR</td>
                                    <td>No ENTRADA</td>
                                    <td>CONTRATO</td>
                                    <td>O.P.</td>
                                    <td>CENTRO DE COSTOS</td>
                                    <td>FECHA DE REGISTRO</td>
                                    <td>FECHA. ULT. ACTUALIZACION.</td>
                                    <td>FECHA LIBERADO</td>
                                    <td>ESTADO</td>
                                    <td>ELABORADO POR</td>
                                </tr>
                            </thead>
                            <tbody>
                                            <% 
                                                DataSource source = PoolConexiones.PoolConexiones();                    
                                                Connection con = source.getConnection();
                                                Statement st = con.createStatement();
                                                ResultSet rs = st.executeQuery("SELECT e.identrada, e.idcliente, e.idciudad, e.idconductor, e.identradaAlmacen, e.lote, e.contrato, e.op, e.centrodecostos, e.fecharecepcion, e.fecharegistrado, e.fechaactualizado, e.fechaliberado, e.estado, e.observacion, ciu.nombreciudad, ciu.direccionciudad, ciu.telefonociudad, cli.nombrecliente, cli.nitcliente, con.cedulaconductor, con.nombreconductor, usu.nombreusuario FROM entrada e   INNER JOIN ciudad ciu ON (e.idciudad = ciu.idciudad)INNER JOIN cliente cli ON (e.idcliente = cli.idcliente) INNER JOIN conductor con ON (e.idconductor = con.idconductor) INNER JOIN usuario usu ON (e.idusuario = usu.idusuario) WHERE e.idcliente>-1  ORDER BY nombrecliente ASC, fecharecepcion ASC");
                                                while(rs.next()){
                                                    out.print("<tr>");
                                                        out.print("<td>");out.print(rs.getInt("identrada"));out.print("</td>");
                                                        out.print("<td class=\"text-nowrap\">");out.print(new Cliente(rs.getInt("idcliente"), rs.getString("nombrecliente"), rs.getString("nitcliente")));out.print("</td>");
                                                        out.print("<td>");out.print(rs.getString("lote"));out.print("</td>");
                                                        out.print("<td class=\"text-nowrap\">");out.print(new java.text.SimpleDateFormat("EEE, d MMM yyyy").format(rs.getDate("fecharecepcion")));out.print("</td>");
                                                        out.print("<td class=\"text-nowrap\">");out.print(new Ciudad(rs.getInt("idciudad"), rs.getString("nombreciudad"), rs.getString("direccionciudad"), rs.getString("telefonociudad")));out.print("</td>");
                                                        out.print("<td class=\"text-nowrap\">");out.print(new Conductor(rs.getInt("idconductor"), rs.getString("cedulaconductor"), rs.getString("nombreconductor")));out.print("</td>");
                                                        out.print("<td>");out.print(rs.getString("identradaAlmacen"));out.print("</td>");
                                                        out.print("<td>");out.print(rs.getString("contrato"));out.print("</td>");
                                                        out.print("<td>");out.print(rs.getString("op"));out.print("</td>");
                                                        out.print("<td class=\"text-nowrap\">");out.print(rs.getString("centrodecostos"));out.print("</td>");
                                                        out.print("<td class=\"text-nowrap\">");out.print(new java.text.SimpleDateFormat("EEE, d MMM yyyy").format(rs.getDate("fecharegistrado")));out.print("</td>");
                                                        out.print("<td>");out.print((null!=rs.getDate("fechaactualizado"))?new java.text.SimpleDateFormat("EEE, d MMM yyyy").format(rs.getDate("fechaactualizado")):"SIN ACTUALIZAR");out.print("</td>");
                                                        out.print("<td>");out.print((null!=rs.getDate("fechaliberado"))?new java.text.SimpleDateFormat("EEE, d MMM yyyy").format(rs.getDate("fechaliberado")):"PENDIENTE");out.print("</td>");
                                                        out.print("<td class=\"text-center\">");out.print("<input type=\"checkbox\" "+((rs.getBoolean("estado")==true)?"checked":"")+" />");out.print("</td>");
                                                        out.print("<td>");out.print(rs.getString("nombreusuario"));out.print("</td>");
                                                    out.print("</tr>");
                                                }
                                                con.close();
                                            %>
                                        </tbody>   
                        </table>                          
                    </div>                    
                </div>
            </div>        	
        </div>

        <footer id="footer">
        	<div class="container">
                <div id="events">
                                
                </div>
            </div>
        </footer>
        
        <!-- LIBRERIA jQuery PARA EL FUNCIONAMIENTO DE JavaScript -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <!-- LIBRERIA PARA DARLE FORMA DINAMICA A LA TABLA  -->
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs-3.3.7/dt-1.10.15/b-1.3.1/fh-3.1.2/datatables.min.js"></script>
        <!-- SUPONGO QUE DEBE SER UN COMPRESOR PARA EL ARCHIVO FINAL EXPORTADO. -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <!-- LIBRERIA PARA EXPORTAR A PDF -->
        <script type="text/javascript" src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/pdfmake.min.js"></script>
        <!-- FUENTES PARA LA EXPORTACION EN PDF -->
        <script type="text/javascript" src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/vfs_fonts.js"></script>
        <!-- ESTILO DE BOTONES DE EXPORTACION. PREFERIBLEMENTE HTML5 PARA MAYOR SOPORTE EN NAVEGADORES -->
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js"></script>
        <!-- IMPRIMIE LA TABLA A UN IMPRESORA DIRECTAMENTE DESDE EL NAVEGADOR -->
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.print.min.js"></script>
        <!-- AGRUPA LA TABLA SEGUN LA COLUMNA SELECCIONADA -->
        <script type="text/javascript" src="https://cdn.datatables.net/rowgroup/1.0.0/js/dataTables.rowGroup.min.js"></script>
        <!-- ESTILO Y FUNCIONAMIENTO PARA MOSTRAR Y SIMULAR LA SELECCION DE FILAS Y CELDAS. -->
        <script type="text/javascript" src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>        

        <script>
        	$(document).ready( function () {

                var table = $('#table_id').DataTable( {
                     /*columnDefs: [ {
                        orderable: false,
                        className: 'select-checkbox',
                        targets:   1
                    } ],*///MUESTRA UN COMPONENTE checkbox EN EL INDICE DE COLUMNA QUE SE ESPECIFIQUE EN EL targets
                    select: true,//MUESTRA UN COLOR AL SELECCIONAR UNA FILA... SE NECEITA DE UNA EXTENSION JS Y CSS
                    scrollY: 300,
                    order: [[1, 'asc']],
                    rowGroup: {
                        startRender: null,
                        endRender: function ( rows, group ) {
                            var salaryAvg = rows
                                .data()
                                .pluck(0)
                                .reduce( function (a, b) {                                    
                                    return a + b.replace(/[^\d]/g, '')*1;
                                }, 0) / rows.count();
                            salaryAvg = $.fn.dataTable.render.number(',', '.', 0, '$').display( salaryAvg );                                        
             
                            return $('<tr/>').append( '<td colspan="15">Sumatoria del grupo: '+group+' es '+salaryAvg+'</td>' );
                        },//SE PUEDE QUITAR TODO EL RENDER PARA QUE MUESTRE SOLO EL ENCABEZADO DE LA AGRUPACION
                        dataSrc: 1
                    },//AGRUPAR FILAS SEGUN LA COLUMNA SELECCIONADA                    
                    dom: 'Bfrtip',
                    lengthMenu: [
                        [ 10, 25, 50, -1 ],
                        [ '10 registros', '25 registros', '50 registros', 'Mostrar todo' ]
                    ],//MUESTRA UN MENU DESPLEGABLE PARA MOSTRAR CIERTA CANTIDAD DE REGISTROS
                    buttons: [                        
                        'pageLength',
                        {
                            extend:    'copyHtml5',
                            text:      '<img src="images/icons/copiar.png" alt="Copiar">',
                            titleAttr: 'Copiar'
                        },
                        {
                            extend:    'excelHtml5',
                            text:      '<img src="images/excel.png" alt="Excel">',
                            titleAttr: 'Exportar tabla a excel'
                        },
                        {
                            extend:    'csvHtml5',
                            text:      '<img src="images/csv.png" alt="CSV">',
                            titleAttr: 'Exportar a formato .CSV'
                        },
                        {
                            extend:    'pdfHtml5',
                            text:      '<img src="images/pdf.png" alt="PDF">',
                            titleAttr: 'Exportar a PDF'
                        },
                        {
                            text: 'Mi Boton KeyEvent',
                            key: {
                                altKey: true,
                                key: '2'
                            },
                            action: function ( e, dt, node, config ) {
                                alert( 'Oprima ALT+2 para accionar este boton' );
                            }                            
                        },
                        {
                            extend: 'print',
                            message: 'Mensaje Opcional',
                            text: '<img src="images/imprimir.png" alt="PDF">',
                            titleAttr: 'Imprimir'
                        },
                        'selectAll'
                    ],//BOTONES DE EXPORTACION
                    "language": {
                        "sProcessing":     "Procesando...",
                        "sLengthMenu":     "Mostrar _MENU_ registros",
                        "sZeroRecords":    "No se encontraron resultados",
                        "sEmptyTable":     "Ningun dato disponible en esta tabla",
                        "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                        "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
                        "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
                        "sInfoPostFix":    "",
                        "sSearch":         "Buscar:",
                        "sUrl":            "",
                        "sInfoThousands":  ",",
                        "sLoadingRecords": "Cargando...",
                        "oPaginate": {
                            "sFirst":    "Primero",
                            "sLast":     "Ultimo",
                            "sNext":     "Siguiente",
                            "sPrevious": "Anterior"
                        },
                        "oAria": {
                            "sSortAscending":  ": Activar para ordenar la columna de manera ascendente.",
                            "sSortDescending": ": Activar para ordenar la columna de manera descendente."
                        }//LENGUAJE DE LOS TEXTOS TABLA
                    },
                    fixedHeader: {
                        "header": true
                    }
                });

                var events = $('#events');
                table.on( 'select', function ( e, dt, type, indexes ) {
                    var rowData = table.rows( indexes ).data().toArray();
                    events.prepend( '<div><b>'+type+' selection</b> - '+JSON.stringify( rowData )+'</div>' );
                } )
                .on( 'deselect', function ( e, dt, type, indexes ) {
                    var rowData = table.rows( indexes ).data().toArray();
                    events.prepend( '<div><b>'+type+' <i>de</i>selection</b> - '+JSON.stringify( rowData )+'</div>' );
                } );

            });		    
        </script>
    </body>
</html>
