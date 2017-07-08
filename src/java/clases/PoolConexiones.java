package clases;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author AUXPLANTA
 */
public class PoolConexiones {


    public static DataSource PoolConexiones(){
        DataSource dataSource = null;
        Context context;
                
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/pooldb");
        } catch (NamingException ex) {
            Logger.getLogger(PoolConexiones.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return dataSource;
    }
    
}
