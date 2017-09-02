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

    <!-- Custom CSS -->
    <link href="css/sb-admin-2/sb-admin-2.css" rel="stylesheet">
    
    <!-- Morris Charts CSS -->
    <link href="css/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">

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
        h1{
            font-family: EnterSans;
            text-align: center;                
        }
    </style>
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <jsp:include page="sidebar2.jsp"></jsp:include>

        <div id="page-wrapper" class="fondobg">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">CDM TRANSFORMADORES</h1>                    
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                
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

    
    
    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2/sb-admin-2.js"></script>
    <script src="js/sb-admin-2/metisMenu.min.js"></script>
    
    <script src="js/charts/morris.min.js"></script>
    <script src="js/charts/raphael-min.js"></script>
    
    
    <script>     
    </script>
</body>

</html>
