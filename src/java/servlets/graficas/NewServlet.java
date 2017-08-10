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
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String sql = "";
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            java.util.Date from = new SimpleDateFormat("dd-MM-yyyy").parse(request.getParameter("from").replace("/", "-"));
            java.util.Date to = new SimpleDateFormat("dd-MM-yyyy").parse(request.getParameter("to").replace("/", "-"));
            String where = (!from.toString().isEmpty()&&!to.toString().isEmpty())?" WHERE fechalaboratorio BETWEEN ''"+from+"'' AND ''"+to+"''  ":"";
            sql = " SELECT * FROM crosstab(\n" +
            " 'SELECT extract(year from fechalaboratorio) AS ano, extract(month from fechalaboratorio) AS mes, count(*) \n" +
            " FROM protocolos  INNER JOIN transformador t USING(idtransformador) INNER JOIN entrada e USING(identrada)\n" +
            " INNER JOIN cliente c USING(idcliente) "+where+" \n" +
            " GROUP BY extract(year from fechalaboratorio), extract(month from fechalaboratorio)\n" +
            " ORDER BY 1, 2') \n" +
            "AS ct(ano double precision, enero bigint, febrero bigint, marzo bigint, abril bigint, mayo bigint, junio bigint, julio bigint, agosto bigint, septiembre bigint, octubre bigint, noviembre bigint, diciembre bigint);";
            
            DataSource source = PoolConexiones.PoolConexiones();
            con = source.getConnection();
            st = con.createStatement();
            rs = st.executeQuery(sql);                                   
            
            JSONObject json = new JSONObject();            
            JSONArray array = new JSONArray();
            try{
                while(rs.next()){
                    
                    JSONObject json1 = new JSONObject();
                    
                    json1.put("name", rs.getString("ano"));
                    
                    json1.put("data", new int[]{
                        rs.getInt(2),rs.getInt(3),rs.getInt(4),
                        rs.getInt(5),rs.getInt(6),rs.getInt(7),
                        rs.getInt(8),rs.getInt(9),rs.getInt(10),
                        rs.getInt(11),rs.getInt(12),rs.getInt(13)
                    });
                    array.put(json1);
                }
                json.put("cantidad", array);
                
                sql = "SELECT * FROM crosstab(\n" +
                " 'SELECT extract(year from fechalaboratorio) AS ano,  extract(month from fechalaboratorio) AS mes,\n" +
                "sum(t.kvasalida) FROM protocolos p INNER JOIN transformador t USING(idtransformador)\n" +
                "INNER JOIN entrada e USING(identrada)\n" +
                "INNER JOIN cliente c USING(idcliente)  "+where+"  \n" +
                "GROUP BY extract(year from fechalaboratorio), extract(month from fechalaboratorio)\n" +
                "ORDER BY 1, 2') \n" +
                "AS ct(ano double precision, enero double precision, febrero double precision, marzo double precision, "
                + "abril double precision, mayo double precision, junio double precision, julio double precision, "
                + "agosto double precision, septiembre double precision, octubre double precision, "
                + "noviembre double precision, diciembre double precision)";
                
                rs = st.executeQuery(sql);
                JSONArray array2 = new JSONArray();
                while(rs.next()){
                    JSONObject json1 = new JSONObject();
                    
                    json1.put("name", rs.getString("ano"));
                    
                    json1.put("data", new int[]{
                        rs.getInt(2),rs.getInt(3),rs.getInt(4),
                        rs.getInt(5),rs.getInt(6),rs.getInt(7),
                        rs.getInt(8),rs.getInt(9),rs.getInt(10),
                        rs.getInt(11),rs.getInt(12),rs.getInt(13)
                    });
                    array2.put(json1);
                }
                json.put("totalkva", array2);
                
                
                sql = "SELECT to_char(fechalaboratorio, 'TMMonth') AS mes, extract(year from fechalaboratorio), t.serviciosalida, count(*) \n" +
                    "  FROM protocolos p INNER JOIN transformador t USING(idtransformador)\n" +
                    "INNER JOIN entrada e USING(identrada)\n" +
                    "INNER JOIN cliente c USING(idcliente)  WHERE fechalaboratorio BETWEEN '01-01-2017' AND '09-08-2017'  "
                    + "GROUP BY to_char(fechalaboratorio, 'TMMonth'), extract(year from fechalaboratorio),  "
                    + "t.serviciosalida, extract(month from fechalaboratorio)  "
                    + "ORDER BY extract(month from fechalaboratorio) ASC";
                
                rs = st.executeQuery(sql);
                JSONArray array3 = new JSONArray();
                
                JSONObject jsonMes = new JSONObject();
                while(rs.next()){
                    
                    jsonMes.put("mes", rs.getString("mes"));
                    
                    
                    array3.put(jsonMes);
                }
                
                json.put("totalservicios", array3);
            }catch(JSONException ex){                
                Logger.getLogger(NewServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
//            Gson gson = new GsonBuilder().setPrettyPrinting().serializeNulls().setFieldNamingPolicy(FieldNamingPolicy.UPPER_CAMEL_CASE).create();
            out.println(json.toString());
        } catch (Exception ex) {
            Logger.getLogger(ServletGraficaCantidad.class.getName()).log(Level.SEVERE, null, ex);
            out.print(ex);
            out.print("<html><script>alert('"+ex+"');</script></html>");
        } finally {
            try {
                con.close();
                rs.close();
                st.close();                
            } catch (SQLException ex) {
                Logger.getLogger(NewServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
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
