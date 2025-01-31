package modelo;

import java.io.Serializable;

public class Parque implements Serializable {
    private int idParque;
    private String nombreParque;
    private String coordenadas; // JSON en formato {"lat": X, "lng": Y}

    public Parque(int idParque, String nombreParque, String coordenadas) {
        this.idParque = idParque;
        this.nombreParque = nombreParque;
        this.coordenadas = coordenadas;
    }

    public int getIdParque() {
        return idParque;
    }

    public void setIdParque(int idParque) {
        this.idParque = idParque;
    }

    public String getNombreParque() {
        return nombreParque;
    }

    public void setNombreParque(String nombreParque) {
        this.nombreParque = nombreParque;
    }

    public String getCoordenadas() {
        return coordenadas;
    }

    public void setCoordenadas(String coordenadas) {
        this.coordenadas = coordenadas;
    }
}
