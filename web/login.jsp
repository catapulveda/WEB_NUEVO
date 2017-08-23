<%@page session="true" %>
<%-- 
    Document   : index
    Created on : 17/07/2017, 10:40:36 AM
    Author     : AUXPLANTA
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>SB Admin 2 - Bootstrap Admin Theme</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-theme.min.css" rel="stylesheet">
    
        <!-- MetisMenu CSS -->
        <link href="css/sb-admin-2/metisMenu.min.css" rel="stylesheet">
        
        <!-- Custom CSS -->
        <link href="css/sb-admin-2/sb-admin-2.css" rel="stylesheet">
        
        <!-- Custom Fonts -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">
        
        <!-- Timeline CSS -->
        <link href="css/sb-admin-2/timeline.css" rel="stylesheet">
        
        <!-- Login CSS -->
        <link href="css/login.css" rel="stylesheet">

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
            <div class="container">
                <div class="row">                    
                    <div class="col-md-6 col-md-offset-3">
                        <div class="panel panel-login" style="margin-top: 25%;">
                            <div class="panel-heading">
                                ${errorSesion}
                                <div class="row">
                                    <div class="col-xs-6">
                                        <a href="#" class="active" id="login-form-link">Iniciar sesion</a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="#" id="register-form-link">Registrarme</a>
                                    </div>
                                </div>
                                
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">

                                        <form id="login-form" action="login?action=login" method="post" role="form" style="display: block;">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw"></i></span>
                                                    <input type="text" name="email" id="username" tabindex="1" class="form-control" placeholder="Correo electronico">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                                                    <input type="password" name="password" id="passwordlogin" tabindex="2" class="form-control" placeholder="Contraseña">
                                                </div>
                                            </div>
                                            <div class="form-group text-center">
                                                <input type="checkbox" tabindex="3" class="" name="remember" id="remember">
                                                <label for="remember">Recordarme</label>
                                            </div>                                            
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-6 col-sm-offset-3">
                                                            <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-primary" value="Iniciar">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="text-center">
                                                                <a href="#" tabindex="5" class="forgot-password">Olvidaste la contraseña?</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>

                                        <form id="register-form" action="login?action=register" method="post" data-toggle="validator" role="form" style="display: none;">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-user" aria-hidden="true"></i></span>
                                                    <input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Usuario" data-error="Ingrese su nombre" required>
                                                </div>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw" aria-hidden="true"></i></span>
                                                    <input type="email" name="email" id="email" tabindex="1" class="form-control" placeholder="Correo electronico" data-error="Ingrese un correo electronico" required>
                                                </div>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-key fa-fw" aria-hidden="true"></i></span>
                                                    <input type="password" name="password" id="password" data-minlength="6" tabindex="2" class="form-control" placeholder="Contraseña">
                                                </div>
                                                <div class="help-block">Minimo 6 caracteres para la contraseña</div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-key fa-fw" aria-hidden="true"></i></span>
                                                    <input type="password" name="confirm-password" id="confirm-password" data-match="#password" data-match-error="Las contraseñas no coinciden." tabindex="2" class="form-control" placeholder="Confirmar contraseña" required>
                                                </div>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-6 col-sm-offset-3">
                                                            <input type="submit" name="btnRegistrar" id="btnRegistrar" tabindex="4" class="form-control btn btn-success" value="Registrarme">
                                                    </div>
                                                </div>
                                            </div>
                                        </form>

                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer">
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        
        <!-- jQuery -->
        <script src="js/jquery-3.2.1.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/validator.js"></script>
        
        <script>
             $('#login-form-link').click(function(e) {
                //$("#login-form").delay(500).fadeIn(300);
                //$("#register-form").fadeOut(300);
                    
                $("#login-form").delay(300).slideDown('slow');
                $("#register-form").slideUp('slow');
                    
                $('#register-form-link').removeClass('active');
                $(this).addClass('active');
                e.preventDefault();
            });
            $('#register-form-link').click(function(e) {
                //$("#register-form").delay(500).fadeIn(300);
                //$("#login-form").fadeOut(300);
                $("#register-form").delay(300).slideDown('slow');
                $("#login-form").slideUp('slow');
                $('#login-form-link').removeClass('active');
                $(this).addClass('active');
                e.preventDefault();
            });
        </script>
    </body>
</html>




