package servlets.lotes;

import clases.Ciudad;
import clases.Cliente;
import clases.Conductor;
import clases.PoolConexiones;
import com.google.gson.JsonElement;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
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
import servlets.clientes.ServletRegistrarCliente;

/**
 *
 * @author AUXPLANTA
 */
public class ServletListarLotes extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");        
        PrintWriter out = response.getWriter();
        DataSource source = PoolConexiones.PoolConexiones();
        Connection con = null;
        try {
            con = source.getConnection();
            Statement st = con.createStatement();
            String sql = "SELECT e.identrada, e.idcliente, e.idciudad, e.idconductor, e.identradaAlmacen, e.lote, e.contrato, e.op, e.centrodecostos, e.fecharecepcion, e.fecharegistrado, e.fechaactualizado, e.fechaliberado, e.estado, e.observacion, ciu.nombreciudad, ciu.direccionciudad, ciu.telefonociudad, cli.nombrecliente, cli.nitcliente, con.cedulaconductor, con.nombreconductor, usu.nombreusuario FROM entrada e   INNER JOIN ciudad ciu ON (e.idciudad = ciu.idciudad)INNER JOIN cliente cli ON (e.idcliente = cli.idcliente) INNER JOIN conductor con ON (e.idconductor = con.idconductor) INNER JOIN usuario usu ON (e.idusuario = usu.idusuario) WHERE e.idcliente>-1  ORDER BY nombrecliente ASC, fecharecepcion ASC";
            ResultSet rs = st.executeQuery(sql);
            org.json.simple.JSONArray jsonArray = new org.json.simple.JSONArray();
            org.json.simple.JSONObject jsonObject = null;
            while(rs.next()){
                jsonObject = new org.json.simple.JSONObject();
                jsonObject.put("identrada", "<button type='button' name='verLote' id='"+rs.getInt("identrada")+"' class='btn btn-default btn-xs verLote'title='Ver lote' ><span class='glyphicon glyphicon-eye-open'></span></button>");
                jsonObject.put("cliente", new Cliente(rs.getInt("idcliente"), rs.getString("nombrecliente"), rs.getString("nitcliente")).toString());
                jsonObject.put("lote", rs.getString("lote"));
                jsonObject.put("fecharecepcion", new SimpleDateFormat("EEE, d MMM yyyy").format(rs.getDate("fecharecepcion")));
                jsonObject.put("ciudad", new Ciudad(rs.getInt("idciudad"), rs.getString("nombreciudad"), rs.getString("direccionciudad"), rs.getString("telefonociudad")).toString());
                jsonObject.put("conductor", new Conductor(rs.getInt("idconductor"), rs.getString("cedulaconductor"), rs.getString("nombreconductor")).toString());
                jsonObject.put("identradaalmacen", rs.getString("identradaAlmacen"));
                jsonObject.put("contrato", rs.getString("contrato"));
                jsonObject.put("op", rs.getString("op"));
                jsonObject.put("centrodecostos", rs.getString("centrodecostos"));
                jsonObject.put("fechaderegistro", new SimpleDateFormat("EEE, d MMM yyyy").format(rs.getDate("fecharegistrado")));
                jsonObject.put("fechaactualizado", (null!=rs.getDate("fechaactualizado"))?new SimpleDateFormat("EEE, d MMM yyyy").format(rs.getDate("fechaactualizado")):"SIN ACTUALIZAR");
                jsonObject.put("fechaliberado", (rs.getDate("fechaliberado")==null)?"":rs.getDate("fechaliberado").toString());
                jsonObject.put("estado", rs.getBoolean("estado"));
                jsonObject.put("nombreusuario", rs.getString("nombreusuario"));
                
                jsonArray.add(jsonObject);
            }
            //out.println(jsonArray);
            out.print(" {\"data\":"+jsonArray+"} ");
        } catch (SQLException ex) {
            Logger.getLogger(ServletRegistrarCliente.class.getName()).log(Level.SEVERE, null, ex);
            out.print("<script>");
            out.print("alertify.error("+ex.getMessage()+")");
            out.print("</script>");
        } finally {            
            try {
                con.close();
            }catch(SQLException ex){
                Logger.getLogger(ServletRegistrarCliente.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    public static com.google.gson.JsonArray convertToJSON(ResultSet resultSet) throws Exception {
        com.google.gson.JsonArray jsonArray = new com.google.gson.JsonArray();
        while (resultSet.next()) {
            int total_rows = resultSet.getMetaData().getColumnCount();
            com.google.gson.JsonObject obj = new com.google.gson.JsonObject();            
            for (int i = 0; i < total_rows; i++) {
                obj.add(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), (JsonElement) resultSet.getObject(i + 1));
            }
          jsonArray.add(obj);
        }
        return jsonArray;
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
