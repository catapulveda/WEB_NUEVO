package servlets.clientes;

import clases.PoolConexiones;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 *
 * @author AUXPLANTA
 */
public class ServletListarClientes extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String sql = "SELECT * FROM cliente ORDER BY nombrecliente";
            DataSource source = PoolConexiones.PoolConexiones();                    
            Connection con = source.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            org.json.simple.JSONArray datos = new org.json.simple.JSONArray();
            while(rs.next()){
                org.json.simple.JSONObject obj = new org.json.simple.JSONObject();
                obj.put("nit", rs.getString("nitcliente"));
                obj.put("nombre", rs.getString("nombrecliente"));
//                obj.put("nit", " <div contenteditable class='update' data-id='"+rs.getInt("idcliente")+"' data-column='nitcliente'>"+rs.getString("nitcliente")+"</div> ");                
//                obj.put("nombre", " <div contenteditable class='update' data-id='"+rs.getInt("idcliente")+"' data-column='nombrecliente'>"+rs.getString("nombrecliente")+"</div> ");
                obj.put("acciones", "<button type='button' name='actualizar' id='"+rs.getInt("idcliente")+"' class='btn btn-info btn-xs actualizar'title='Actualizar' ><span class='glyphicon glyphicon-edit'></span></button> <button type='button' name='eliminar' id='"+rs.getInt("idcliente")+"' class='btn btn-danger btn-xs eliminar' title='Eliminar'><span class='glyphicon glyphicon-trash'></span></button>");
                datos.add(obj);
            }            
            out.print(" {\"data\":"+datos.toJSONString()+"} ");
        } catch (SQLException ex) {
            Logger.getLogger(ServletListarClientes.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
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
