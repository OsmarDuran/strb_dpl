package modelo;

import java.util.Date;

public class EmpleadoParque implements java.io.Serializable {
    private int idAsignacion;
    private int idEmpleado;
    private int idParque;
    private Date fechaAsignacion;

    public EmpleadoParque() {}

    public EmpleadoParque(int idAsignacion, int idEmpleado, int idParque, Date fechaAsignacion) {
        this.idAsignacion = idAsignacion;
        this.idEmpleado = idEmpleado;
        this.idParque = idParque;
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

    public int getIdParque() {
        return idParque;
    }

    public void setIdParque(int idParque) {
        this.idParque = idParque;
    }

    public Date getFechaAsignacion() {
        return fechaAsignacion;
    }

    public void setFechaAsignacion(Date fechaAsignacion) {
        this.fechaAsignacion = fechaAsignacion;
    }
}
