<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
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
        <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <sql:setDataSource var="dataSource"
                           driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/rh_database"
                           user="root"
                           password="azerty" />
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
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="glyphicon glyphicon-user"></i>
                                <sql:query dataSource="${dataSource}" var="result">
                                    select *
                                    from employe e
                                    where cin_employe=?
                                    <sql:param value="${param.cin_chef}"></sql:param>
                                </sql:query>
                                <c:forEach var="row" items="${result.rows}">

                                    <td><c:out value="${row.nom_employe}" /> <c:out value="${row.prenom_employe}" /></td>

                                </c:forEach>
                                <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li class="dropdown-header">Se connecter En tant que :</li>
                                <li><a href="employe.jsp?cin_employe=${param.cin_chef}">Employé</a></li>
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

        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-3 col-md-2 sidebar">
                    <ul class="nav nav-sidebar">
                        <li class="active"><a data-toggle="tab" href="#conges">Congés<span class="badge pull-right">
                                    <sql:query dataSource="${dataSource}" var="result">
                                        select count(*) as count
                                        from arret a, employe e, departement d
                                        where type_arret= ? and status_arret="Attente Validation DRH"
                                        and e.cin_employe= a.cin_employe and  d.num_departement = e.num_departement;

                                        <sql:param value="conge_annuel"></sql:param>

                                    </sql:query>
                                    <c:forEach var="row" items="${result.rows}">
                                        <c:out value="${row.count}"/>
                                    </c:forEach>
                                </span></a></li>
                        <li><a data-toggle="tab" href="#maladies">Maladies<span class="badge pull-right"><sql:query dataSource="${dataSource}" var="result">
                                        select count(*) as count
                                        from arret a, employe e, departement d
                                        where type_arret= ? and status_arret="Non justifie"
                                        and e.cin_employe= a.cin_employe and  d.num_departement = e.num_departement;

                                        <sql:param value="autorisation_maladie"></sql:param>

                                    </sql:query>
                                    <c:forEach var="row" items="${result.rows}">
                                        <c:out value="${row.count}"/>
                                    </c:forEach></span></a></li>
                        <li><a data-toggle="tab" href="#autorisations">Autorisations<span class="badge pull-right"><sql:query dataSource="${dataSource}" var="result">
                                        select count(*) as count
                                        from arret a, employe e, departement d
                                        where type_arret= ? and status_arret="Attente Validation DRH"
                                        and e.cin_employe= a.cin_employe and  d.num_departement = e.num_departement;

                                        <sql:param value="autorisation_exceptionnelle"></sql:param>

                                    </sql:query>
                                    <c:forEach var="row" items="${result.rows}">
                                        <c:out value="${row.count}"/>
                                    </c:forEach></span></a></li>
                    </ul>
                </div>
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main tab-content">

                    <div id="conges" class="tab-pane active">
                        <h1>Congés</h1>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>CIN</th>
                                        <th>Nom</th>
                                        <th>Prénom</th>
                                        <th>Département</th>
                                        <th>Date Debut</th>
                                        <th>Date Fin</th>

                                        <th>Durée</th>
                                        <th>Pret</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <sql:query dataSource="${dataSource}" var="result">
                                        select *
                                        from arret a, employe e, departement d
                                        where type_arret= ? and status_arret="Attente Validation DRH"
                                        and e.cin_employe= a.cin_employe and  d.num_departement = e.num_departement;

                                        <sql:param value="conge_annuel"></sql:param>

                                    </sql:query>
                                    <c:forEach var="row" items="${result.rows}">
                                        <tr class="${row.status_arret}">
                                            <td><c:out value="${row.num_arret}" /></td>
                                            <td><c:out value="${row.cin_employe}" /></td>
                                            <td><c:out value="${row.nom_employe}" /></td>
                                            <td><c:out value="${row.prenom_employe}" /></td>
                                            <td><c:out value="${row.designation_departement}" /></td>
                                            <td><c:out value="${row.date_debut}" /></td>
                                            <td><c:out value="${row.date_fin}" /></td>
                                            <td>
                                                <jsp:useBean id="arret" class="com.RHmanager.org.Arret" scope="request" />
                                                <jsp:setProperty name="arret" property="date_debut" value="${row.date_debut}"/>
                                                <jsp:setProperty name="arret" property="date_fin" value="${row.date_fin}"/>
                                                <jsp:getProperty name="arret" property="duration"/>
                                            </td>
                                            <td><c:out value="${row.pret_conge}" /></td>
                                            <td>
                                            <td>
                                                <form action="UpdateArret" method="post" style="display:inline-block">
                                                    <input type="text" name="is_drh" value="oui" hidden="true">
                                                    <input type="text" name="cin_chef" value="${param.cin_chef}" hidden="true">
                                                    <input type="text" name="num_arret" value="${row.num_arret}" hidden="true">
                                                    <input type="text" name="status_arret" value="Accepte" hidden="true">
                                                    <button type="submit" class="btn btn-success">
                                                        <i value="" class="glyphicon glyphicon-ok"></i> Confirmé
                                                    </button>
                                                </form>
                                                <form action="UpdateArret" method="post" style="display:inline-block">
                                                    <input type="text" name="is_drh" value="oui" hidden="true">

                                                    <input type="text" name="cin_chef" value="${param.cin_chef}" hidden="true">
                                                    <input type="text" name="num_arret" value="${row.num_arret}" hidden="true">
                                                    <input type="text" name="status_arret" value="Refuse par DRH" hidden="true">
                                                    <button class="btn btn-danger">
                                                        <option value="Refusé" class="glyphicon glyphicon-remove"></i> Refusé
                                                    </button>
                                                </form>


                                            </td>

                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>


                    </div>
                    <div id="maladies" class="tab-pane">
                        <h1>Maladies</h1>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>CIN</th>
                                        <th>Nom</th>
                                        <th>Prénom</th>
                                        <th>Département</th>
                                        <th>Date Debut</th>
                                        <th>Date Fin</th>

                                        <th>Durée</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <sql:query dataSource="${dataSource}" var="result">
                                        select *
                                        from arret a, employe e, departement d
                                        where type_arret= ? and status_arret="Non justifie"
                                        and e.cin_employe= a.cin_employe and  d.num_departement = e.num_departement;

                                        <sql:param value="autorisation_maladie"></sql:param>

                                    </sql:query>
                                    <c:forEach var="row" items="${result.rows}">
                                        <tr class="${row.status_arret}">
                                            <td><c:out value="${row.num_arret}" /></td>
                                            <td><c:out value="${row.cin_employe}" /></td>
                                            <td><c:out value="${row.nom_employe}" /></td>
                                            <td><c:out value="${row.prenom_employe}" /></td>
                                            <td><c:out value="${row.designation_departement}" /></td>
                                            <td><c:out value="${row.date_debut}" /></td>
                                            <td><c:out value="${row.date_fin}" /></td>
                                            <td>
                                                <jsp:useBean id="arret_mala" class="com.RHmanager.org.Arret" scope="request" />
                                                <jsp:setProperty name="arret_mala" property="date_debut" value="${row.date_debut}"/>
                                                <jsp:setProperty name="arret_mala" property="date_fin" value="${row.date_fin}"/>
                                                <jsp:getProperty name="arret_mala" property="duration"/>
                                            </td>
                                            <td>
                                            <td>
                                                <form action="UpdateArret" method="post" style="display:inline-block">
                                                    <input type="text" name="is_drh" value="oui" hidden="true">
                                                    <input type="text" name="cin_chef" value="${param.cin_chef}" hidden="true">
                                                    <input type="text" name="num_arret" value="${row.num_arret}" hidden="true">
                                                    <input type="text" name="status_arret" value="Justifie" hidden="true">
                                                    <button type="submit" class="btn btn-success">
                                                        <i value="" class="glyphicon glyphicon-ok"></i> Justifier
                                                    </button>
                                                </form>



                                            </td>

                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div id="autorisations" class="tab-pane">
                        <h1>Autorisations</h1>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>CIN</th>
                                        <th>Nom</th>
                                        <th>Prénom</th>
                                        <th>Département</th>
                                        <th>Date Debut</th>
                                        <th>Date Fin</th>

                                        <th>Durée</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <sql:query dataSource="${dataSource}" var="result">
                                        select *
                                        from arret a, employe e, departement d
                                        where type_arret= ? and status_arret="Attente Validation DRH"
                                        and e.cin_employe= a.cin_employe and  d.num_departement = e.num_departement;

                                        <sql:param value="autorisation_exceptionnelle"></sql:param>

                                    </sql:query>
                                    <c:forEach var="row" items="${result.rows}">
                                        <tr class="${row.status_arret}">
                                            <td><c:out value="${row.num_arret}" /></td>
                                            <td><c:out value="${row.cin_employe}" /></td>
                                            <td><c:out value="${row.nom_employe}" /></td>
                                            <td><c:out value="${row.prenom_employe}" /></td>
                                            <td><c:out value="${row.designation_departement}" /></td>
                                            <td><c:out value="${row.date_debut}" /></td>
                                            <td><c:out value="${row.date_fin}" /></td>
                                            <td>
                                                <jsp:useBean id="arret_auto" class="com.RHmanager.org.Arret" scope="request" />
                                                <jsp:setProperty name="arret_auto" property="date_debut" value="${row.date_debut}"/>
                                                <jsp:setProperty name="arret_auto" property="date_fin" value="${row.date_fin}"/>
                                                <jsp:getProperty name="arret_auto" property="duration"/>
                                            </td>
                                            <td>
                                            <td>
                                                <form action="UpdateArret" method="post" style="display:inline-block">
                                                    <input type="text" name="is_drh" value="oui" hidden="true">
                                                    <input type="text" name="cin_chef" value="${param.cin_chef}" hidden="true">
                                                    <input type="text" name="num_arret" value="${row.num_arret}" hidden="true">
                                                    <input type="text" name="status_arret" value="Accepte" hidden="true">
                                                    <button type="submit" class="btn btn-success">
                                                        <i value="" class="glyphicon glyphicon-ok"></i> Confirmé
                                                    </button>
                                                </form>
                                                <form action="UpdateArret" method="post" style="display:inline-block">
                                                    <input type="text" name="is_drh" value="oui" hidden="true">

                                                    <input type="text" name="cin_chef" value="${param.cin_chef}" hidden="true">
                                                    <input type="text" name="num_arret" value="${row.num_arret}" hidden="true">
                                                    <input type="text" name="status_arret" value="Refuse par DRH" hidden="true">
                                                    <button class="btn btn-danger">
                                                        <option value="Refusé" class="glyphicon glyphicon-remove"></i> Refusé
                                                    </button>
                                                </form>


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
        <script>
            (function(b, o, i, l, e, r) {
                b.GoogleAnalyticsObject = l;
                b[l] || (b[l] =
                        function() {
                            (b[l].q = b[l].q || []).push(arguments)
                        });
                b[l].l = +new Date;
                e = o.createElement(i);
                r = o.getElementsByTagName(i)[0];
                e.src = '//www.google-analytics.com/analytics.js';
                r.parentNode.insertBefore(e, r)
            }(window, document, 'script', 'ga'));
            ga('create', 'UA-XXXXX-X', 'auto');
            ga('send', 'pageview');
        </script>
    </body>

</html>