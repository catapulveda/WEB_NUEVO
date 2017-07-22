package servlets.login;

import clases.PoolConexiones;
import clases.Usuario;
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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

public class ServletLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String correo = request.getParameter("email").toUpperCase();
        String pass = request.getParameter("password");
        String sql = "SELECT * FROM usuario WHERE correo='"+correo+"' AND pass=md5('"+pass+"' || '"+correo+"' || 'cdmtransformadores') ";
        DataSource source = PoolConexiones.PoolConexiones();
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            con = source.getConnection();
            st = con.createStatement();
            rs = st.executeQuery(sql);            
            
            if(rs.next()){
                Usuario usuario = new Usuario(rs.getInt("idusuario"), rs.getString("nombreusuario"), rs.getString("correo"), rs.getString("pass"));
                HttpSession sesion = request.getSession(true);                
                sesion.setAttribute("usuario", usuario);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }else{
                request.setAttribute("errorSesion", "Los datos de usuario no existen.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            request.setAttribute("errorSesion", "Los datos de usuario no existen. "+ex);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            //Logger.getLogger(ServletLogin.class.getName()).log(Level.SEVERE, null, ex);        
        } finally {
            try {if(con!=null)con.close();if(st!=null)st.close();if(rs!=null)rs.close();} catch (SQLException ex) {Logger.getLogger(ServletLogin.class.getName()).log(Level.SEVERE, null, ex);}
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
