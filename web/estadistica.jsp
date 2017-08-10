<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Bienvenido ${usuario.toString()}</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-theme.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="css/sb-admin-2/metisMenu.min.css" rel="stylesheet">    
    <!-- Timeline CSS -->
    <link href="css/sb-admin-2/timeline.css" rel="stylesheet">    

    <!-- Chart CSS -->
    <link href="css/morris.css" rel="stylesheet">    

    <!-- Custom CSS -->
    <link href="css/sb-admin-2/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- Alertify Version Nueva-->
    <link rel="stylesheet" href="css/alertify/alertify.css">    
    <link rel="stylesheet" href="css/alertify/themes/bootstrap.min.css" />
    
    <!-- jQueryUI-->
    <link href="css/jquery-ui.css" rel="stylesheet" media="screen">        

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <jsp:include page="sidebar2.jsp"></jsp:include>

        <div id="page-wrapper" class="fondobg">
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12 text-center">                    
                    <form class="form-inline">
                        <div class="form-group">
                            <label>Seleccione un rango de fecha:</label>
                            <div class="input-group">                                
                                <input type="text" class="form-control input-sm" id="from" placeholder="Desde">
                                <div class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <input class="form-control input-sm" type="text" id="to" placeholder="Hasta">
                                <div class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <hr/>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Cantidad de transformadores intervenidos
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                        Actions
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu pull-right" role="menu">
                                        <li><a href="#">Action</a>
                                        </li>
                                        <li><a href="#">Another action</a>
                                        </li>
                                        <li><a href="#">Something else here</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li><a href="#">Separated link</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="chartCount"></div>
                        </div>
                        
                        <div class="panel-footer">
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
            </div>
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Total KVA Producios                            
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="chartKVA"></div>
                        </div>
                        
                        <div class="panel-footer">
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
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
    
    <!-- Bootstrap HighCharts-->
    <script src="js/highcharts/highcharts.js"></script>
    <script src="js/highcharts/exporting.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/sb-admin-2/metisMenu.min.js"></script>


    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2/sb-admin-2.js"></script>
    
    <!-- Alertas Version Nueva -->
    <script src="js/alertify/alertify.js"></script>
    
    <!-- datetimepicker -->
    <script type="text/javascript" src="js/jquery-ui.js" charset="UTF-8"></script>    
    
    <script>                        
        $(document).ready(function(){
            
            var dateFormat = "mm/dd/yy",
            
                from = $( "#from" ).datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1
                }).on( "change", function() {
                    to.datepicker( "option", "minDate", getDate( this ) );
                    if( $('#from').val() && $('#to').val() ){
                        cargar();
                    }
                }),

                to = $( "#to" ).datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1
                }).on( "change", function() {
                    from.datepicker( "option", "maxDate", getDate( this ) );
                    if( $('#from').val() && $('#to').val() ){
                        cargar();
                    }
                });
            
            var options = {
                exporting: {
                    chartOptions: { // specific options for the exported image
                        plotOptions: {
                            series: {
                                dataLabels: {
                                    enabled: true
                                }
                            }
                        }
                    },
                    fallbackToExportServer: false
                },
                chart: {
                    type: 'column'
                },
                xAxis: {
                    categories: [
                        'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
                    ],
                    crosshair: true
                },
                title: {
                    text: 'tittle'
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: "Total"
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:f}</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                legend: {
                    enabled: true
                },
                plotOptions: {
                    series: {
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            format: '{point.y}'
                        }
                    }
                },
                series: [{}]
            };
            
            
            var url =  "http://localhost:8080/WEB/NewServlet?from=01/01/2016&to=08/08/2017";            
            $.getJSON(url,  function(data) {
                options.chart.renderTo = 'chartCount';
                options.series = data.cantidad;
                options.title.text = 'Total Intervenidos';
                var chartCount = new Highcharts.Chart(options);
                
                var opciones = options;
                opciones.chart.renderTo = 'chartKVA';
                opciones.series = data.totalkva;
                opciones.title.text = 'Total KVA Producidos';
                var chartKVA = new Highcharts.Chart(opciones);
            });
                                          
        });
        
        function cargar(){
            var url =  "http://localhost:8080/WEB/NewServlet?from=01/02/2017&to=04/02/2017";            
            $.getJSON(url,  function(data) {                
                options.series[0] = data.series;                
                var chart = new Highcharts.Chart(options);
                
            });
        }
        
        function cargarGrafica(grafica, datos, tittle, ejeY){
            $.ajax({
                url : "NewServlet?from="+$("#from").val()+"&to="+$("#to").val(),
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown);
                },
                success : function(data) {
                    Highcharts.chart('chartKVA', {                                                                                                                        
                        
                        series: [{}]
                    });
                }
            });
        }
        
        function getDate( element ) {
            var date;
            try {
                date = $.datepicker.parseDate( dateFormat, element.value );
            } catch( error ) {
                date = null;
            }
            return date;
        }
    </script>
</body>

</html>
