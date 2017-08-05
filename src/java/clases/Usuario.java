package clases;

public class Usuario {

    private int idusuario;
    private String nombre;
    private String correo;
    private String pass;
    
    public Usuario(int idusuario, String nombre, String correo, String pass) {
        this.idusuario = idusuario;
        this.nombre = nombre;
        this.correo = correo;
        this.pass = pass;
    }

    public int getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(int idusuario) {
        this.idusuario = idusuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    @Override
    public String toString() {
        return nombre;
    }
    
    
}
