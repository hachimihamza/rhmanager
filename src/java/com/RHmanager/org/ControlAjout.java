/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RHmanager.org;

import java.sql.*;
import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Hamza
 */
public class ControlAjout extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            String str_date_debut = request.getParameter("date_debut");
            String str_date_fin = request.getParameter("date_fin");
            String type_arret = request.getParameter("type_arret");
            String status_arret = request.getParameter("status_arret");
            String cin_employe = request.getParameter("cin_employe");
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rh_database", "root", "azerty");
            Statement stmt;
            String sql;
            Arret arret = new Arret();
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            arret.setDate_debut(format.parse(str_date_debut));
            arret.setDate_fin(format.parse(str_date_fin));

            if (arret.comparerDate() == false) {
                request.getRequestDispatcher("employe.jsp?cin_employe=" + cin_employe + "&erreur=date+fin+doit+être+supérieure+à+date+début").forward(request, response);
            } else if (type_arret.equals("autorisation_exceptionnelle")) {
                stmt = con.createStatement();
                sql = "insert into arret values(NULL,'"
                        + str_date_debut + "','"
                        + str_date_fin + "','"
                        + type_arret + "','"
                        + status_arret + "','"
                        + cin_employe + "')";
                stmt.executeUpdate(sql);
                con.close();
                request.getRequestDispatcher("employe.jsp?cin_employe=" + cin_employe + "&confirmation=Votre+Demande+est+Envoyee").forward(request, response);
            } else if (type_arret.equals("autorisation_maladie")) {
                stmt = con.createStatement();
                status_arret = "Non justifie";
                sql = "insert into arret values(NULL,'"
                        + str_date_debut + "','"
                        + str_date_fin + "','"
                        + type_arret + "','"
                        + status_arret + "','"
                        + cin_employe + "')";
                stmt.executeUpdate(sql);
                con.close();
                request.getRequestDispatcher("employe.jsp?cin_employe=" + cin_employe + "&confirmation=Votre+Demande+est+Envoyee").forward(request, response);
            } else {

                stmt = con.createStatement();
                sql = "select * from employe where cin_employe = '" + cin_employe + "'";
                ResultSet rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    int pret_conge;
                    pret_conge = rs.getInt("pret_conge");
                    long duration;
                    duration = arret.getDuration();
                    if (duration > pret_conge) {
                        request.getRequestDispatcher("employe.jsp?cin_employe=" + cin_employe + "&refus=votre+demande+est+refusée+:+durée+est+supérieur+au+prêt+disponible").forward(request, response);
                    } else {
                        stmt = con.createStatement();
                        sql = "insert into arret values(NULL,'"
                                + str_date_debut + "','"
                                + str_date_fin + "','"
                                + type_arret + "','"
                                + status_arret + "','"
                                + cin_employe + "')";
                        stmt.executeUpdate(sql);
                        con.close();
                        request.getRequestDispatcher("employe.jsp?cin_employe=" + cin_employe + "&confirmation=Votre+Demande+est+Envoyee").forward(request, response);
                    }
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ControlAjout.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ControlAjout.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(ControlAjout.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
