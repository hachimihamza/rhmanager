/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RHmanager.org;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ConnectionImpl;
import static java.lang.System.out;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Hamza
 */
public class Arret {

    private int num_arret;
    private Date date_debut;
    private Date date_fin;
    private String type_arret;
    private String status_arret;
    private String cin_employe;
    private int duration;
    private long pret_conge;
    private Date date_recrutement;

    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/rh_database";

    //  Database credentials
    static final String USER = "root";
    static final String PASS = "azerty";

    public Arret() {

    }

    public int getNum_arret() {
        return num_arret;
    }

    public void setNum_arret(int num_arret) {
        this.num_arret = num_arret;
    }

    public Date getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(Date date_debut) {
        this.date_debut = date_debut;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date date_fin) {
        this.date_fin = date_fin;
    }

    public String getType_arret() {
        return type_arret;
    }

    public void setType_arret(String type_arret) {
        this.type_arret = type_arret;
    }

    public String getStatus_arret() {
        return status_arret;
    }

    public void setStatus_arret(String status_arret) {
        this.status_arret = status_arret;
    }

    public String getCin_employe() {
        return cin_employe;
    }

    public void setCin_employe(String cin_employe) {
        this.cin_employe = cin_employe;
    }

    public long getDuration() {
        return (date_fin.getTime() - date_debut.getTime() + 86400000) / (1000 * 60 * 60 * 24);

    }

    public boolean comparerDate() {
        return date_fin.after(date_debut);
    }

    public void setPret_conge(long pret_conge) {
        Date now = new Date();
        long nb_annee = ((now.getTime() - date_recrutement.getTime()) / (1000 * 60 * 60 * 24)) / 365;
        this.pret_conge = 21 + nb_annee;
    }

    public long getPret_conge() {
        return pret_conge;
    }

    public Date getDate_recrutement() {
        return date_recrutement;
    }

    public void setDate_recrutement(Date date_recrutement) {
        this.date_recrutement = date_recrutement;
    }

}
