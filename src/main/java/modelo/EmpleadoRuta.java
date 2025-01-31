package modelo;

import java.io.Serializable;
import java.util.Date;

public class EmpleadoRuta implements Serializable {
    private int idAsignacion;
    private int idEmpleado;
    private int idRuta;
    private Date fechaAsignacion;

    public EmpleadoRuta() {}

    public EmpleadoRuta(int idAsignacion, int idEmpleado, int idRuta, Date fechaAsignacion) {
        this.idAsignacion = idAsignacion;
        this.idEmpleado = idEmpleado;
        this.idRuta = idRuta;
        this.fechaAsignacion = fechaAsignacion;
    }

    public int getIdAsignacion() {
        return idAsignacion;
    }

    public void setIdAsignacion(int idAsignacion) {
        this.idAsignacion = idAsignacion;
    }

    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public int getIdRuta() {
        return idRuta;
    }

    public void setIdRuta(int idRuta) {
        this.idRuta = idRuta;
    }

    public Date getFechaAsignacion() {
        return fechaAsignacion;
    }

    public void setFechaAsignacion(Date fechaAsignacion) {
        this.fechaAsignacion = fechaAsignacion;
    }
}
