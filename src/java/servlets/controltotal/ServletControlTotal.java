package servlets.controltotal;

import clases.Cliente;
import clases.PoolConexiones;
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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ServletControlTotal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            DataSource source = PoolConexiones.PoolConexiones();
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
            con = source.getConnection();
            st = con.createStatement();
            
            String sql = "SELECT e.identrada, cli.nombrecliente, e.lote, t.numeroserie,\n" +
            "t.numeroempresa, t.fase, t.marca, t.kvasalida, t.estado, r.numero_remision,\n" +
            "d.nodespacho, e.fecharecepcion, ciu.nombreciudad, e.contrato, e.op, e.centrodecostos\n" +
            "FROM entrada e INNER JOIN transformador t USING(identrada)\n" +
            "INNER JOIN cliente cli USING (idcliente)\n" +
            "INNER JOIN ciudad ciu USING (idciudad) \n" +
            "LEFT JOIN despacho d USING(iddespacho)\n" +
            "LEFT JOIN remision r USING(idremision)\n" +
            "ORDER BY e.idcliente, e.fecharecepcion";
            
            rs = st.executeQuery(sql);
            
            JSONObject json = new JSONObject();
            org.json.simple.JSONArray datos = new JSONArray();

            while(rs.next()){
                org.json.simple.JSONObject object = new JSONObject();
                               
                object.put("identrada", rs.getInt("identrada"));
                object.put("nombrecliente", rs.getString("nombrecliente"));
                object.put("lote", rs.getString("lote"));                
                object.put("numeroempresa", rs.getString("numeroempresa"));
                object.put("fase", rs.getInt("fase"));
                object.put("marca", rs.getString("marca"));
                datos.add(object);
            }
            
            json.put("data", datos);
            
            out.println(json.toJSONString());
        } catch (Exception ex) {
            out.println("ERROR "+ex);
            Logger.getLogger(ServletControlTotal.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
