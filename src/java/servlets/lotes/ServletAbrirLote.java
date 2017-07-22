package servlets.lotes;

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

public class ServletAbrirLote extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        DataSource source = PoolConexiones.PoolConexiones();
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        try {            
            con = source.getConnection();
            st = con.createStatement();
            String sql = " SELECT e.*, t.*, r.numero_remision FROM entrada e ";
            sql += " INNER JOIN transformador t ON t.identrada=e.identrada  ";
            sql += " LEFT JOIN remision r ON t.idremision=r.idremision ";
            sql += " INNER JOIN cliente c ON c.idcliente=e.idcliente  ";
            sql += " INNER JOIN conductor co ON co.idconductor=e.idconductor  ";
            sql += " WHERE e.identrada="+request.getParameter("idlote")+" ";
            sql += " "+((Boolean.parseBoolean(request.getParameter("order")))?"ORDER BY fase ASC, kvaentrada ASC, marca":"ORDER BY item" )+" ";
            rs = st.executeQuery(sql);
            org.json.simple.JSONArray jsonArray = new org.json.simple.JSONArray();
            org.json.simple.JSONObject jsonObject = null;
            while(rs.next()){
                jsonObject = new org.json.simple.JSONObject();
                    jsonObject.put("idtransformador", rs.getInt("idtransformador"));
                    jsonObject.put("item", rs.getInt("item"));//"N°",
                    jsonObject.put("numero_remision", rs.getString("numero_remision"));//"N° REMISION",
                    jsonObject.put("numeroempresa", rs.getString("numeroempresa"));//"N° EMPRESA",
                    jsonObject.put("numeroserie", rs.getString("numeroserie"));//"N° SEIRE",
                    jsonObject.put("marca", rs.getString("marca"));//"MARCA",
                    jsonObject.put("kvaentrada", rs.getDouble("kvaentrada"));//"KVA",
                    jsonObject.put("fase", rs.getInt("fase"));//"FASE",
                    jsonObject.put("tpe", rs.getString("tpe")+"/"+rs.getString("tse")+"/"+rs.getString("tte"));//"TENSION P",
                    jsonObject.put("aat", rs.getString("aat"));//"A.T",
                    jsonObject.put("abt", rs.getString("abt"));//"B.T",
                    jsonObject.put("hat", rs.getString("hat"));//"H.A",
                    jsonObject.put("hbt", rs.getString("hbt"));//"H.B",
                    jsonObject.put("ci", rs.getBoolean("ci"));//"INT",
                    jsonObject.put("ce", rs.getBoolean("ce"));//"EXT",
                    jsonObject.put("herraje", rs.getString("herraje"));//"HERRAJE",
                    jsonObject.put("ano", rs.getInt("ano"));//"AÑO",
                    jsonObject.put("peso", rs.getInt("peso"));//"PESO",
                    jsonObject.put("aceite", rs.getInt("aceite"));//"ACEITE",
                    jsonObject.put("observacionentrada", rs.getString("observacionentrada"));//"OBSERVACION",
                    jsonObject.put("servicioentrada", rs.getString("servicioentrada"));//"SERVICIO",
                    jsonObject.put("tipotrafoentrada", rs.getString("tipotrafoentrada"));//"TIPO", 
                jsonArray.add(jsonObject);
            }
            String result = "{";
            result += " \"draw\":1, ";
            result += " \"recordsTotal\":50, ";
            result += " \"recordsFiltered\":50, ";
            result += " \"data\":"+jsonArray+" ";
            result += "}";
            out.print(result);
        } catch (SQLException ex) {
            Logger.getLogger(ServletAbrirLote.class.getName()).log(Level.SEVERE, null, ex);
            out.print("<script>");
            out.print("alertify.error("+ex.getMessage()+")");
            out.print("</script>");
        } finally {
            try {if(con!=null)con.close();if(st!=null)st.close();if(rs!=null)rs.close();} catch (SQLException ex) {Logger.getLogger(ServletAbrirLote.class.getName()).log(Level.SEVERE, null, ex);}
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
