package servlets.graficas;

import clases.PoolConexiones;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author AUXPLANTA
 */
public class NewServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String sql = "";
        try {
            String from = new SimpleDateFormat("dd/MM/yyyy").format("01/01/2017");
            String to = new SimpleDateFormat("dd/MM/yyyy").format("01/08/2017");
            String where = ( true)?" WHERE fechalaboratorio BETWEEN ''01-01-2017'' AND ''01-08-2017''  ":"";
            sql = " SELECT * FROM crosstab(\n" +
            " 'SELECT extract(year from fechalaboratorio) AS ano, extract(month from fechalaboratorio) AS mes, count(*) \n" +
            " FROM protocolos  INNER JOIN transformador t USING(idtransformador) INNER JOIN entrada e USING(identrada)\n" +
            " INNER JOIN cliente c USING(idcliente) "+where+" \n" +
            " GROUP BY extract(year from fechalaboratorio), extract(month from fechalaboratorio)\n" +
            " ORDER BY 1, 2') \n" +
            "AS ct(ano double precision, enero bigint, febrero bigint, marzo bigint, abril bigint, mayo bigint, junio bigint, julio bigint, agosto bigint, septiembre bigint, octubre bigint, noviembre bigint, diciembre bigint);";
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
            DataSource source = PoolConexiones.PoolConexiones();
            con = source.getConnection();
            st = con.createStatement();
            rs = st.executeQuery(sql);
                                    
            ResultSetMetaData rsmd = rs.getMetaData();                                                            
            
            JSONObject json = new JSONObject();            
            JSONArray array = new JSONArray();
            try{
                while(rs.next()){                    
                    
                    JSONObject json1 = new JSONObject();
                    
                    json1.put("name", rs.getString("ano"));
                    
                    int columnas = rsmd.getColumnCount()-1;
                    json1.put("data", new int[]{
                        rs.getInt(2),rs.getInt(3),rs.getInt(4),
                        rs.getInt(5),rs.getInt(5),rs.getInt(6),
                        rs.getInt(7),rs.getInt(8),rs.getInt(9),
                        rs.getInt(10),rs.getInt(11),rs.getInt(12)
                    });
                    array.put(json1);
                }                                
                json.put("series", array);
            }catch(JSONException ex){
                Logger.getLogger(NewServlet.class.getName()).log(Level.SEVERE, null, ex);
            }            
            
//            Gson gson = new GsonBuilder().setPrettyPrinting().serializeNulls().setFieldNamingPolicy(FieldNamingPolicy.UPPER_CAMEL_CASE).create();
            out.println(json.toString());
        } catch (Exception ex) {
            Logger.getLogger(ServletGraficaCantidad.class.getName()).log(Level.SEVERE, null, ex);
            out.print("<div clas='alert alert-danger>Error "+ex+"</div>");
        } finally {
            out.println(sql);
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
