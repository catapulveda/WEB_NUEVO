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
        //response.setContentType("text/html;charset=UTF-8");
        //PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");        
        
        DataSource source = PoolConexiones.PoolConexiones();
        Connection con = null;
        Statement st = null;
        try{
            con = source.getConnection();
            st = con.createStatement();
        }catch(SQLException ex){Logger.getLogger(ServletLogin.class.getName()).log(Level.SEVERE, null, ex);}        
                
        ResultSet rs = null;
        String sql = null;
        String correo = request.getParameter("email").toUpperCase();
        String pass = request.getParameter("password");
        if(action.equals("login")){
            
            sql = "SELECT * FROM usuario WHERE correo='"+correo+"' AND pass=md5('"+pass+"' || '"+correo+"' || 'cdmtransformadores') ";
            try {                
                rs = st.executeQuery(sql);

                if(rs.next()){
                    Usuario usuario = new Usuario(rs.getInt("idusuario"), rs.getString("nombreusuario"), rs.getString("correo"), rs.getString("pass"));
                    HttpSession sesion = request.getSession(true);                
                    sesion.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }else{
                    request.setAttribute("errorSesion", "<div class='alert alert-danger'>El correo o contraseña no coinciden.</div>");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } catch (SQLException ex) {
                request.setAttribute("errorSesion", "<div class='alert alert-danger'>Ocurrió un error inesperado.\n"+ex+"</div>");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                //Logger.getLogger(ServletLogin.class.getName()).log(Level.SEVERE, null, ex);        
            } finally {
                try {if(con!=null)con.close();if(st!=null)st.close();if(rs!=null)rs.close();} catch (SQLException ex) {Logger.getLogger(ServletLogin.class.getName()).log(Level.SEVERE, null, ex);}
                //out.close();
            }
        }else if(action.equals("register")){
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirm_pass = request.getParameter("confirm-password");
            
            sql = "SELECT correo FROM usuario WHERE correo='"+email+"' ";
            try {
                rs = st.executeQuery(sql);
                if(rs.next()){
                    request.setAttribute("errorSesion", "<div class='alert alert-danger'>El correo ya se encuentra en uso.</div>");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }else{
                    sql = "INSERT INTO usuario (nombreusuario,pc,recordar,correo,pass) VALUES(";
                    sql += " '"+username+"' , '"+request.getRemoteAddr()+"' , false, '"+email+"' , md5('"+pass+"' || '"+correo+"' || 'cdmtransformadores') ";
                    sql += " ) ";
                    if(st.executeUpdate(sql)>0){
                        response.sendRedirect("login?action=login");
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(ServletLogin.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("errorSesion", "<div class='alert alert-danger'>Error al ejecutar la consulta.\n"+ex+"</div>");
                request.getRequestDispatcher("login.jsp").forward(request, response);                
            }
        }                                        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("action")==null){
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }else if(request.getParameter("action").equals("logout")){
            HttpSession sesion = request.getSession();
            sesion.removeAttribute("username");
            sesion.invalidate();
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }else if(request.getParameter("action").equals("login")){
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
