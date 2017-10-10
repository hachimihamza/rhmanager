/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RHmanager.org;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class CheckUser extends HttpServlet {

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
            out.println("<!doctype html>\n"
                    + "<!--[if lt IE 7]>      <html class=\"no-js lt-ie9 lt-ie8 lt-ie7\" lang=\"\"> <![endif]-->\n"
                    + "<!--[if IE 7]>         <html class=\"no-js lt-ie9 lt-ie8\" lang=\"\"> <![endif]-->\n"
                    + "<!--[if IE 8]>         <html class=\"no-js lt-ie9\" lang=\"\"> <![endif]-->\n"
                    + "<!--[if gt IE 8]><!-->\n"
                    + "<html class=\"no-js\" lang=\"\">\n"
                    + "    <!--<![endif]-->\n"
                    + "\n"
                    + "    <head>\n"
                    + "        <meta charset=\"utf-8\">\n"
                    + "        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\">\n"
                    + "        <title></title>\n"
                    + "        <meta name=\"description\" content=\"\">\n"
                    + "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
                    + "        <link rel=\"apple-touch-icon\" href=\"apple-touch-icon.png\">\n"
                    + "\n"
                    + "        <link rel=\"stylesheet\" href=\"css/bootstrap.min.css\">\n"
                    + "        <link rel='stylesheet' href='css/fullcalendar.min.css' />\n"
                    + "        <link rel=\"stylesheet\" href=\"css/bootstrap-theme.min.css\">\n"
                    + "        <link rel=\"stylesheet\" href=\"css/signin.css\">\n"
                    + "\n"
                    + "        <script src=\"js/vendor/modernizr-2.8.3-respond-1.4.2.min.js\"></script>\n"
                    + "    </head>\n"
                    + "\n"
                    + "    <body>\n"
                    + "        <!--[if lt IE 8]>\n"
                    + "                <p class=\"browserupgrade\">You are using an <strong>outdated</strong> browser. Please <a href=\"http://browsehappy.com/\">upgrade your browser</a> to improve your experience.</p>\n"
                    + "            <![endif]-->\n"
                    + "        <nav class=\"navbar navbar-inverse navbar-fixed-top\">\n"
                    + "            <div class=\"container-fluid\">\n"
                    + "                <div class=\"navbar-header\">\n"
                    + "                    <a class=\"navbar-brand\" href=\"#\">RH Manager</a>\n"
                    + "                </div>\n"
                    + "            </div>\n"
                    + "        </nav>\n"
                    + "\n"
                    + "        <div class=\"container\"><br>");

            String username = request.getParameter("username");
            String motdepasse = request.getParameter("motdepasse");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rh_database", "root", "azerty");
            Statement stmt = con.createStatement();
            String sql = "select * from employe where username = '" + username + "' and motdepasse ='" + motdepasse + "'";
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                //request.getRequestDispatcher("acceuil.jsp?" + rs.getString("cin_employe")).forward(request, response);
                out.println("<div class='well text-center'><h2 class=\"form-signin-heading text-center\">Se Connecter en tant que :</h2>");
                out.println("<a href='employe.jsp?cin_employe=" + rs.getString("cin_employe") + "'>Employe</a><br>");
                if (rs.getInt("is_admin") == 1) {
                    out.println("<a href='administrateur.jsp?cin_employe=" + rs.getString("cin_employe") + "'> Administarteur </a>");
                }
                String sqlc = "select * from chef where cin_chef = '" + rs.getString("cin_employe") + "'";
                ResultSet rsc = stmt.executeQuery(sqlc);
                if (rsc.next()) {
                    out.println("<br><a href='chefDepartement.jsp?cin_chef=" + rsc.getString("cin_chef") + "'>Chef Département</a><br>");
                    String sqld = "select * from departement where designation_departement = 'RH' and cin_chef ='" + rsc.getString("cin_chef") + "'";
                    ResultSet rsd = stmt.executeQuery(sqld);
                    if (rsd.next()) {
                        out.println("<br><a href='directeurRH.jsp?cin_chef=" + rsd.getString("cin_chef") + "'>Directeur RH</a><br>");
                    }
                }
                out.println("</div>");
            } else {
                out.println("Votre login ou mot de passe incorrect");
                out.println("<a href='index.jsp'>Réssayer</a><br>");
            }
            con.close();

            out.println("</div> <script src=\"//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js\"></script>\n"
                    + "        <script>\n"
                    + "            window.jQuery || document.write('<script src=\"js/vendor/jquery-1.11.2.min.js\"><\\/script>')\n"
                    + "        </script>\n"
                    + "\n"
                    + "        <script src=\"js/vendor/bootstrap.min.js\"></script>\n"
                    + "        <script src='js/vendor/moment.min.js'></script>\n"
                    + "        <script src=\"js/vendor/fullcalendar.min.js\"></script>\n"
                    + "        <script src=\"js/main.js\"></script>\n"
                    + "    </body>\n"
                    + "\n"
                    + "</html>");

        } catch (SQLException ex) {
            Logger.getLogger(CheckUser.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CheckUser.class.getName()).log(Level.SEVERE, null, ex);
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
