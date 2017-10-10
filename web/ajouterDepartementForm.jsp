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
                                <li><a href="employe.html">Employ�</a></li>
                                <!--
                                    <li><a href="chefDepartement.html">Chef De Service</a></li>
                                -->
                            </ul>
                        </li>
                        <li>
                            <a href="index.jsp">
                                <i class="glyphicon glyphicon-log-out"></i> Se D�connecter
                            </a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>
        <div class="row">
            <div class="col-md-offset-3 col-md-6">
                <div class="well">
                    <h4 class="text-center text-uppercase">Ajout D�partement</h4>
                    <form action="ajouterDepartement.jsp" method="post">

                        <div class="form-group">
                            <label for="designation_departement">Designation Departement</label>
                            <input type="text" class="form-control" name="designation_departement">
                        </div>
                        <div class="form-group">
                            <label for="cin_chef">CIN Chef</label>
                            <input type="text" class="form-control" name="cin_chef">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-success">Sauvegarder</button>
                            <button class="btn btn-danger"><a href="administrateur.jsp" >Annuler</a></button>
                        </div>
                    </form>
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
