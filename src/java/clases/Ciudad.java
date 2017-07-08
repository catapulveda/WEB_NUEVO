package clases;
 
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JComboBox;

/**
 *
 * @author AUXPLANTA
 */
public class Ciudad {

    private int idCiudad;
    private String nombreCiudad;
    private String direccionCiudad;
    private String telefonoCiudad;   
    
    public Ciudad(int idCiudad, String nombreCiudad, String direccionCiudad, String telefonoCiudad){
        this.idCiudad = idCiudad;
        this.nombreCiudad = nombreCiudad;
        this.direccionCiudad = direccionCiudad;
        this.telefonoCiudad = telefonoCiudad;
    }
    
    public int getIdCiudad(){
        return idCiudad;
    }

    public void setIdCiudad(int idCiudad) {
        this.idCiudad = idCiudad;
    }

    public String getNombreCiudad() {
        return nombreCiudad;
    }

    public void setNombreCiudad(String nombreCiudad) {
        this.nombreCiudad = nombreCiudad;
    }

    public String getDireccionCiudad() {
        return direccionCiudad;
    }

    public void setDireccionCiudad(String direccionCiudad) {
        this.direccionCiudad = direccionCiudad;
    }

    public String getTelefonoCiudad() {
        return telefonoCiudad;
    }

    public void setTelefonoCiudad(String telefonoCiudad) {
        this.telefonoCiudad = telefonoCiudad;
    }   
    
    @Override
    public String toString(){
        return nombreCiudad+" "+direccionCiudad;
    }    
    
}
