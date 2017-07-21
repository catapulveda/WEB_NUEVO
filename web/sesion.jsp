<%@page session="true" %>
<%
HttpSession sesion = request.getSession(false);
if(sesion.getAttribute("usuario")==null){
    request.setAttribute("errorSesion", "Debe iniciar sesion");
    request.getRequestDispatcher("login.jsp").forward(request, response);        
}

%>