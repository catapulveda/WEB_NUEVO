package servlets.login;

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

public class ServletRegister extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        DataSource source = PoolConexiones.PoolConexiones();
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            String msj = null;
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirm_password = request.getParameter("confirm-password");
            
            String sql = "SELECT correo FROM usuario WHERE correo='"+email+"' ";
            con = source.getConnection();
            st = con.createStatement();
            rs = st.executeQuery(sql);
            if(rs.next()){
                msj = "El correo electronico ya se encuentra en uso.";
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServletRegister.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);        
        //request.getRequestDispatcher("lotes.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        //request.getRequestDispatcher("clientes.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para el registro del usuario";
    }// </editor-fold>

}
