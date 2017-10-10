/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RHmanager.org;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
public class UpdateArret extends HttpServlet {

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

            String num_arret = request.getParameter("num_arret");
            String status_arret = request.getParameter("status_arret");
            String cin_chef = request.getParameter("cin_chef");
            String is_drh = request.getParameter("is_drh");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rh_database", "root", "azerty");
            Statement stmt = con.createStatement();
            String sql = "update arret set status_arret = '" + status_arret + "' where num_arret = " + num_arret;
            stmt.executeUpdate(sql);

            if (is_drh.equals("oui")) {
                if (status_arret.equals("Accepte")) {
                    Arret arret = new Arret();
                    String cin_employe;
                    int pret;
                    long duration;
                    long pret_conge_mod;
                    sql = "select * from arret a, employe e where a.cin_employe = e.cin_employe and num_arret =" + num_arret;
                    ResultSet rs = stmt.executeQuery(sql);
                    if (rs.next()) {
                        cin_employe = rs.getString("cin_employe");
                        pret = rs.getInt("pret_conge");
                        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                        arret.setDate_debut(format.parse(rs.getString("date_debut")));
                        arret.setDate_fin(format.parse(rs.getString("date_fin")));
                        duration = arret.getDuration();
                        pret_conge_mod = pret - duration;
                        sql = "update employe set pret_conge = '" + pret_conge_mod + "' where cin_employe = '" + cin_employe + "'";
                        stmt.executeUpdate(sql);
                    }
                }
                request.getRequestDispatcher("directeurRH.jsp?cin_chef=" + cin_chef).forward(request, response);
            } else {
                request.getRequestDispatcher("chefDepartement.jsp?cin_chef=" + cin_chef).forward(request, response);
            }

            con.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateArret.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateArret.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(UpdateArret.class.getName()).log(Level.SEVERE, null, ex);
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
