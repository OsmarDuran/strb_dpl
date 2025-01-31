package modelo;

import java.io.Serializable;

public class Ruta implements Serializable {
    private int idRuta;
    private String nombreRuta;
    private int tipoRuta;
    private String color;
    private boolean estado;
    private String coordenadas;

    public Ruta() {}

    public Ruta(int idRuta, String nombreRuta, int tipoRuta, String color, boolean estado, String coordenadas) {
        this.idRuta = idRuta;
        this.nombreRuta = nombreRuta;
        this.tipoRuta = tipoRuta;
        this.color = color;
        this.estado = estado;
        this.coordenadas = coordenadas;
    }

    public int getIdRuta() {
        return idRuta;
    }

    public void setIdRuta(int idRuta) {
        this.idRuta = idRuta;
    }

    public String getNombreRuta() {
        return nombreRuta;
    }

    public void setNombreRuta(String nombreRuta) {
        this.nombreRuta = nombreRuta;
    }

    public int getTipoRuta() {
        return tipoRuta;
    }

    public void setTipoRuta(int tipoRuta) {
        this.tipoRuta = tipoRuta;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public String getCoordenadas() {
        return coordenadas;
    }

    public void setCoordenadas(String coordenadas) {
        this.coordenadas = coordenadas;
    }
}
