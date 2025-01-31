package modelo;

import java.io.Serializable;

public class Turno implements Serializable {
    private int idTurno;
    private String nombreTurno;
    private String horaInicio;
    private String horaFin;
    private String diasOperacion;

    // Constructor vacío
    public Turno() {}

    // Constructor con parámetros
    public Turno(int idTurno, String nombreTurno, String horaInicio, String horaFin, String diasOperacion) {
        this.idTurno = idTurno;
        this.nombreTurno = nombreTurno;
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.diasOperacion = diasOperacion;
    }

    // Getters y Setters
    public int getIdTurno() {
        return idTurno;
    }

    public void setIdTurno(int idTurno) {
        this.idTurno = idTurno;
    }

    public String getNombreTurno() {
        return nombreTurno;
    }

    public void setNombreTurno(String nombreTurno) {
        this.nombreTurno = nombreTurno;
    }

    public String getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(String horaInicio) {
        this.horaInicio = horaInicio;
    }

    public String getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(String horaFin) {
        this.horaFin = horaFin;
    }

    public String getDiasOperacion() {
        return diasOperacion;
    }

    public void setDiasOperacion(String diasOperacion) {
        this.diasOperacion = diasOperacion;
    }
}
