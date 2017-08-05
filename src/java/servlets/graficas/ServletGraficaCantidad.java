package servlets.graficas;

import clases.PoolConexiones;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

public class ServletGraficaCantidad extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String sql = " SELECT * FROM crosstab(\n" +
            " 'SELECT extract(year from fechalaboratorio) AS ano, extract(month from fechalaboratorio) AS mes, count(*) \n" +
            " FROM protocolos  INNER JOIN transformador t USING(idtransformador) INNER JOIN entrada e USING(identrada)\n" +
            " INNER JOIN cliente c USING(idcliente)  \n" +
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
            org.json.simple.JSONArray datos = new org.json.simple.JSONArray();
            org.json.simple.JSONArray meses = new org.json.simple.JSONArray();
            
            ResultSetMetaData rsmd = rs.getMetaData();
            while(rs.next()){
                Gson gson = new Gson();
                com.google.gson.JsonArray jsonArray = new com.google.gson.JsonArray();
                com.google.gson.JsonElement jsonElement = new com.google.gson.JsonObject();
                
                org.json.simple.JSONObject obj = new org.json.simple.JSONObject();
                obj.put("ano", String.valueOf(rs.getInt("ano")));
                
                org.json.simple.JSONObject mes = new org.json.simple.JSONObject();
                                
                for(int i=1; i<rsmd.getColumnCount(); i++){
                    mes.put(rsmd.getColumnName(i), (rs.getInt(i)>0)?rs.getInt(i):null);
                }
                meses.add(mes);
                
                datos.add(obj);                
            }
            datos.add(meses);
            //out.print(" {\"data\":"+datos.toJSONString()+"} ");
            out.print(datos.toJSONString());
//            String n = datos.toString().replace("[", "").replace("]", "");

        } catch (SQLException ex) {
            Logger.getLogger(ServletGraficaCantidad.class.getName()).log(Level.SEVERE, null, ex);
            out.print("<div clas='alert alert-danger>Error "+ex+"</div>");
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
