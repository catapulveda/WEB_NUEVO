package servlets.clientes;

import clases.PoolConexiones;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.swing.JOptionPane;

public class ServletRegistrarCliente extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        DataSource source = PoolConexiones.PoolConexiones();
        Connection con = null;
        Statement st = null;
        String sql = null;
        String json = "{";
        try {            
            con = source.getConnection();
            st = con.createStatement();                       
            String accion = request.getParameter("action");
            String mensaje = "NULL";           
            if(accion.equals("registrar")){
                sql = "INSERT INTO cliente (nombrecliente,nitcliente) VALUES ('"+request.getParameter("nombre")+"' , '"+request.getParameter("nit")+"')";
                //mensaje = "<div class=\"alert alert-success\"><button class=\"close\" data-dismiss=\"alert\"><span>&times;</span></button><span class='glyphicon glyphicon-ok'></span> Cliente registrado!</div>";
//                obj.put("mensaje","El cliente se ha registrado!");
//                obj.put("html", "<div class=\"alert alert-success\"><button class=\"close\" data-dismiss=\"alert\"><span>&times;</span></button><span class='glyphicon glyphicon-ok'></span> Cliente registrado!</div>");
                json += " \"mensaje\":\"<em>El cliente se ha registrado!</em>\" ";
                json += ",";
                json += " \"html\":\"<div class='alert alert-success'><span class='glyphicon glyphicon-ok'></span> Cliente registrado!</div>\" ";
            }else if(accion.equals("eliminar")){
                sql = "DELETE FROM cliente WHERE idcliente="+request.getParameter("idcliente");
                //mensaje = "<div class=\"alert alert-success\"><button class=\"close\" data-dismiss=\"alert\"><span>&times;</span></button><span class='glyphicon glyphicon-ok'></span> Cliente eliminado</div>";
//                obj.put("mensaje","El cliente ha sido borrado!");
//                obj.put("html", "<div class=\"alert alert-success\"><button class=\"close\" data-dismiss=\"alert\"><span>&times;</span></button><span class='glyphicon glyphicon-ok'></span> Cliente eliminado</div>");
                json += " \"mensaje\":\"<em>El cliente ha sido borrado!</em>\" ";
                json += ",";
                json += " \"html\":\"<div class='alert alert-success'><button class='close' data-dismiss='alert'><span>&times;</span></button><span class='glyphicon glyphicon-ok'></span> Cliente eliminado</div>\" ";
            }else if(accion.equals("editar")){
                if(null==request.getParameter("opcion")){
                    sql = "UPDATE cliente SET "+request.getParameter("column_name")+"='"+request.getParameter("text")+"' WHERE idcliente="+request.getParameter("idcliente");
                }else{
                    sql = "UPDATE cliente SET nombrecliente='"+request.getParameter("nombre")+"' , nitcliente='"+request.getParameter("nit")+"' WHERE idcliente="+request.getParameter("idcliente")+" ";
                }                
                //mensaje = "<div class=\"alert alert-success\"><button class=\"close\" data-dismiss=\"alert\"><span>&times;</span></button><span class='glyphicon glyphicon-ok'></span> Datos actualizados!</div>";
//                obj.put("mensaje","El cliente ha sido actualizado!");
//                obj.put("html", "<div class=\"alert alert-success\"><button class=\"close\" data-dismiss=\"alert\"><span>&times;</span></button><span class='glyphicon glyphicon-ok'></span> Datos actualizados!</div>");
                json += " \"mensaje\":\"<em>El cliente ha sido actualizado!</em>\" ";
                json += ",";
                json += " \"html\":\"<div class='alert alert-success'><button class='close' data-dismiss='alert'><span>&times;</span></button><span class='glyphicon glyphicon-ok'></span> Datos actualizados!</div>\" ";
            }
            int n = st.executeUpdate(sql);
            if(n<=0){
//                obj.put("mensaje", "ERROR AL EJECUTAR LA CONSULTA");                
//                obj.put("html", "<div class=\"alert alert-danger\"><button class=\"close\" data-dismiss=\"alert\"><span>&times;</span></button><span class='glyphicon glyphicon-remove'></span> Advertencia: NO SE EJECUTO LA CONSULTA.</div>");
                json = "{ \"mensaje\":\"<em>ERROR AL EJECUTAR LA CONSULTA</em>\" ";
                json += ",";
                json += " \"html\":<div class='alert alert-danger'><span class='glyphicon glyphicon-remove'></span> Advertencia: NO SE EJECUTO LA CONSULTA.</div>";
            }             
        } catch (SQLException ex) {
            Logger.getLogger(ServletRegistrarCliente.class.getName()).log(Level.SEVERE, null, ex);
            //out.print("<div class=\"alert alert-danger\"><button class=\"close\" data-dismiss=\"alert\"><span>&times;</span></button><span class='glyphicon glyphicon-remove'></span> Error: "+ex.getMessage()+"</div>");
//            obj.put("html", "<div class=\"alert alert-danger\"><button class=\"close\" data-dismiss=\"alert\"><span>&times;</span></button><span class='glyphicon glyphicon-remove'></span> Error: "+ex.getMessage()+"</div>");
//            obj.put("mensaje", "ERROR AL EJECUTAR LA CONSULTA");
            json = "{ \"mensaje\":\"<em>ERROR AL EJECUTAR LA CONSULTA</em>\" ";
            json += ",";
            json += " \"html\":\"<div class='alert alert-danger'><span class='glyphicon glyphicon-remove'></span> "+ex.getMessage().replace("\n", "").concat(". "+sql)+"</div>\" ";
        } finally {
            json += "}";
            out.print(json);
            out.close();
            try {
                con.close();
            }catch(SQLException ex){
                Logger.getLogger(ServletRegistrarCliente.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {if(con!=null)con.close();if(st!=null)st.close();} catch (SQLException ex) {Logger.getLogger(ServletRegistrarCliente.class.getName()).log(Level.SEVERE, null, ex);}
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
