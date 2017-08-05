<%-- 
    Document   : newjsp
    Created on : 4/08/2017, 09:57:05 AM
    Author     : AUXPLANTA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
          
          
          
            <script src="js/jquery-3.2.1.min.js"></script>
          <script src="js/bootstrap.min.js"></script>
          <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $( function() {
            var dateFormat = "mm/dd/yy",
                from = $( "#from" ).datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1
                }).on( "change", function() {
                    to.datepicker( "option", "minDate", getDate( this ) );
                }),

                to = $( "#to" ).datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1
                }).on( "change", function() {
                    from.datepicker( "option", "maxDate", getDate( this ) );
                });

            function getDate( element ) {
                var date;
                try {
                    date = $.datepicker.parseDate( dateFormat, element.value );
                } catch( error ) {
                    date = null;
                }
                return date;
            }
        } );
  </script>
        <title>JSP Page</title>
    </head>
    <body>
        
    </body>
</html>
