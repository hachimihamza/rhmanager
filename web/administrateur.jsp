<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sql:setDataSource var="dataSource"
                   driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/rh_database"
                   user="root"
                   password="azerty" />
<html class="no-js" lang="">
    <!--<![endif]-->

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="apple-touch-icon.png">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="css/main.css">

    </head>

    <body>
        <!--[if lt IE 8]>
                <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->
        <!-- barre de navigation-->
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">RH Manager</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#">Dashboard</a></li>
                        <li>
                            <a href="#">
                                <i class="glyphicon glyphicon-cog"></i> Settings
                            </a>
                        </li>

                        <li>
                            <a href="index.jsp">
                                <i class="glyphicon glyphicon-log-out"></i> Se Déconnecter
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-3 col-md-2 sidebar">
                    <ul class="nav nav-sidebar">
                        <li class="active"><a data-toggle="tab" href="#employe">Employés</a></li>
                        <li><a data-toggle="tab" href="#chef">Chef Départements</a></li>
                        <li><a data-toggle="tab" href="#departement">Départements</a></li>
                    </ul>
                </div>
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main tab-content">
                    <div id="chef" class="tab-pane">
                        <h3>Chef Départements</h3>
                        <div>
                            <button class="btn"><a href="ajouterChefForm.jsp"><i class="glyphicon glyphicon-plus"></i>Ajouter</a></button>
                        </div>
                        <br>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>cin_chef</th>
                                        <th>Nom_chef</th>
                                        <th>Prénom_chef</th>
                                        <th>adresse</th>
                                        <th>username</th>
                                        <th>motdepasse</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <sql:setDataSource var="dataSource"
                                                       driver="com.mysql.jdbc.Driver"
                                                       url="jdbc:mysql://localhost:3306/rh_database"
                                                       user="root"
                                                       password="azerty" />

                                    <sql:query dataSource="${dataSource}" var="resultat">
                                        select * from chef
                                    </sql:query>
                                    <c:forEach var="row" items="${resultat.rows}" >
                                        <tr>
                                            <td><c:out value="${row.cin_chef}"/></td>
                                            <td><c:out value="${row.nom_chef}"/></td>
                                            <td><c:out value="${row.prenom_chef}"/></td>
                                            <td><c:out value="${row.adresse}"/></td>
                                            <td><c:out value="${row.username}"/></td>
                                            <td><c:out value="${row.motdepasse}"/></td>
                                            <td>
                                                <a href='modifierChefForm.jsp?cin_chef=<c:out value="${row.cin_chef}"/>'}>
                                                    Modifier
                                                </a>
                                            </td>
                                            <td>
                                                <a href='supprimerChef.jsp?cin_chef=<c:out value="${row.cin_chef}"/>'}>
                                                    Supprimer
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>


                    </div>

                    <!--affichage de la table employe-->
                    <div id="employe" class="tab-pane active">
                        <h3>Employés </h3>
                        <div>
                            <button class="btn"><a href="ajouterEmployeForm.jsp"><i class="glyphicon glyphicon-plus"></i>Ajouter</a></button>
                        </div>
                        <br>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>cin_employe</th>
                                        <th>Nom_employe</th>
                                        <th>Prénom_employe</th>
                                        <th>adresse</th>
                                        <th>username</th>
                                        <th>motdepasse</th>
                                        <th>designation_departement</th>
                                        <th>Date Recrurtement</th>
                                        <th>Pret conge</th>
                                        <th>Est Admin</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                                    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
                                    <sql:setDataSource var="dataSource"
                                                       driver="com.mysql.jdbc.Driver"
                                                       url="jdbc:mysql://localhost:3306/rh_database"
                                                       user="root"
                                                       password="azerty" />

                                    <sql:query dataSource="${dataSource}" var="resultat">
                                        select * from employe
                                    </sql:query>
                                    <c:forEach var="row" items="${resultat.rows}" >
                                        <tr>
                                            <td><c:out value="${row.cin_employe}"/></td>
                                            <td><c:out value="${row.nom_employe}"/></td>
                                            <td><c:out value="${row.prenom_employe}"/></td>
                                            <td><c:out value="${row.adresse}"/></td>
                                            <td><c:out value="${row.username}"/></td>
                                            <td><c:out value="${row.motdepasse}"/></td>
                                            <td>
                                                <sql:query dataSource="${dataSource}" var="resultat_departement">
                                                    select designation_departement from departement where num_departement = ?
                                                    <sql:param value="${row.num_departement}" />
                                                </sql:query>
                                                <c:forEach var="sub_row" items="${resultat_departement.rows}" >
                                                    <c:out value="${sub_row.designation_departement}"/>
                                                </c:forEach>
                                            </td>
                                            <td><c:out value="${row.date_recrutement}"/></td>
                                            <td><c:out value="${row.pret_conge}"/></td>
                                            <td><c:out value="${row.is_admin}"/></td>
                                            <td>
                                                <a href='modifierEmployeForm.jsp?cin_employe=<c:out value="${row.cin_employe}"/>'}>
                                                    Modifier
                                                </a>
                                            </td>
                                            <td>
                                                <a href='supprimerEmploye.jsp?cin_employe=<c:out value="${row.cin_employe}"/>'}>
                                                    Supprimer
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>


                    </div>

                    <!-- affichage table departement-->
                    <div id="departement" class="tab-pane">
                        <h3>Départements</h3>

                        <div>
                            <button class="btn">
                                <a href="ajouterDepartementForm.jsp"><i class="glyphicon glyphicon-plus"></i>Ajouter</a></button>

                        </div>
                        <br>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>

                                        <th>num_departement</th>
                                        <th>designation_département</th>
                                        <th>cin_chef</th>
                                        <th>Nom chef</th>
                                        <th>Prenom chef</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                                    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
                                    <sql:setDataSource var="dataSource"
                                                       driver="com.mysql.jdbc.Driver"
                                                       url="jdbc:mysql://localhost:3306/rh_database"
                                                       user="root"
                                                       password="azerty" />

                                    <sql:query dataSource="${dataSource}" var="resultat">
                                        select d.num_departement,
                                        designation_departement,
                                        c.cin_chef,
                                        c.nom_chef,
                                        c.prenom_chef
                                        from departement d
                                        left join chef c
                                        on d.cin_chef = c.cin_chef;
                                    </sql:query>
                                    <c:forEach var="row" items="${resultat.rows}" >
                                        <tr>
                                            <td><c:out value="${row.num_departement}"/></td>
                                            <td><c:out value="${row.designation_departement}"/></td>
                                            <td><c:out value="${row.cin_chef}"/></td>
                                            <td><c:out value="${row.nom_chef}"/></td>
                                            <td><c:out value="${row.prenom_chef}"/></td>

                                            <td>
                                                <a href='modifierDepartementForm.jsp?num_departement=<c:out value="${row.num_departement}"/>'>
                                                    Modifier
                                                </a>
                                            </td>
                                            <td>
                                                <a href='supprimerDepartement.jsp?num_departement=<c:out value="${row.num_departement}"/>'>
                                                    Supprimer
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>









        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>
            window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')
        </script>

        <script src="js/vendor/bootstrap.min.js"></script>
        <script src='js/vendor/moment.min.js'></script>
        <script src="js/vendor/fullcalendar.min.js"></script>
        <script src="js/main.js"></script>

        <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->

    </body>

</html>