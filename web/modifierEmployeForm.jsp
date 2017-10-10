<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<%@page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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
        <link rel='stylesheet' href='css/fullcalendar.min.css' />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="css/main.css">

        <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
    </head>

    <body>
        <!--[if lt IE 8]>
                <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->
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
                        <li><a href="administrateur.jsp" >Dashboard</a></li>
                        <li>
                            <a href="#">
                                <i class="glyphicon glyphicon-cog"></i> Settings
                            </a>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="glyphicon glyphicon-user"></i> John Doe
                                <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li class="dropdown-header">Se connecter En tant que :</li>
                                <li><a href="employe.html">Employé</a></li>
                                <!--
                                    <li><a href="chefDepartement.html">Chef De Service</a></li>
                                -->
                            </ul>
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
        <div class="row">
            <div class="col-md-offset-3 col-md-6">
                <div class="well">
                    <h4 class="text-center text-uppercase">Modification Employe</h4>

                    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
                    <sql:setDataSource var="dataSource"
                                       driver="com.mysql.jdbc.Driver"
                                       url="jdbc:mysql://localhost:3306/rh_database"
                                       user="root"
                                       password="azerty" />
                    <sql:query dataSource="${dataSource}" var="result">
                        select * from employe where cin_employe=?
                        <sql:param value="${param.cin_employe}"/>
                    </sql:query>
                    <c:forEach var="row" items="${result.rows}">
                        <form action="modifierEmploye.jsp" method="post">
                            <div class="form-group">
                                <label for="cin_employe">CIN</label>
                                <input type="text" class="form-control" name="cin_employe" value="${row.cin_employe}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="nom_employe">Nom</label>
                                <input type="text" class="form-control" name="nom_employe" value="${row.nom_employe}">
                            </div>
                            <div class="form-group">
                                <label for="prenom_employe">Prénom</label>
                                <input type="text" class="form-control" name="prenom_employe" value="${row.prenom_employe}">
                            </div>
                            <div class="form-group">
                                <label for="adresse">Adresse</label>
                                <input type="text" class="form-control" name="adresse" value="${row.adresse}">
                            </div>

                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" class="form-control" name="username" value="${row.username}">
                            </div>
                            <div class="form-group">
                                <label for="motdepasse">motdepasse</label>
                                <input type="password" class="form-control" name="motdepasse" value="${row.motdepasse}">
                            </div>
                            <div class="form-group">
                                <label for="designation_departement">Département</label>
                                <div class="form-group">
                                    <select class="form-control" id="sel1" name="num_departement">
                                        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                                        <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
                                        <sql:setDataSource var="dataSource"
                                                           driver="com.mysql.jdbc.Driver"
                                                           url="jdbc:mysql://localhost:3306/rh_database"
                                                           user="root"
                                                           password="azerty" />

                                        <sql:query dataSource="${dataSource}" var="resultat">
                                            select * from Departement
                                        </sql:query>
                                        <c:forEach var="row" items="${resultat.rows}" >

                                            <option  value="${row.num_departement}"><c:out value="${row.designation_departement}"/></option>

                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                Est Admin
                                <label><input type="radio" name="is_admin" value="1">Oui</label>
                                <label><input type="radio" name="is_admin" value="0" checked="true">Non</label>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-success">Sauvegarder</button>
                                <button class="btn btn-danger"><a href="administrateur.jsp" >Annuler</a></button>
                            </div>
                        </form>
                    </c:forEach>
                </div></div></div>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>
            window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')
        </script>

        <script src="js/vendor/bootstrap.min.js"></script>
        <script src='js/vendor/moment.min.js'></script>
        <script src="js/vendor/fullcalendar.min.js"></script>
        <script src="js/main.js"></script>



    </body>

</html>
