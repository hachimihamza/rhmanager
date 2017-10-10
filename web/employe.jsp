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
                                    <sql:param value="${param.cin_employe}"></sql:param>
                                </sql:query>
                                <c:forEach var="row" items="${result.rows}">

                                    <td><c:out value="${row.nom_employe}" /> <c:out value="${row.prenom_employe}" /></td>

                                </c:forEach>
                                <span class="caret"></span></a>

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
                        <li class="active"><a data-toggle="tab" href="#overview">Envoi Demande <span class="sr-only">(current)</span></a></li>
                        <li><a data-toggle="tab" href="#conges">Congés</a></li>
                        <li><a data-toggle="tab" href="#maladies">Maladies</a></li>
                        <li><a data-toggle="tab" href="#autorisations">Autorisations</a></li>
                    </ul>
                </div>
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main tab-content">
                    <div id="overview" class="tab-pane active">

                        <div class="container">
                            <div class="row">
                                <div class="col-md-6 col-md-offset-3 text-center">
                                    <h4 class="text-info">
                                        Votre prêt de congé est
                                        <sql:query dataSource="${dataSource}" var="result">
                                            select *
                                            from employe e
                                            where cin_employe=?
                                            <sql:param value="${param.cin_employe}"></sql:param>
                                        </sql:query>
                                        <c:forEach var="row" items="${result.rows}">

                                            <td><c:out value="${row.pret_conge}" /></td>

                                        </c:forEach> jours
                                    </h4>
                                    <h3>Demande de Congés / Autorisations</h3>
                                    <form action="ControlAjout" method="post">
                                        <input type="text" name="cin_employe" hidden="true" value="${param.cin_employe}">

                                        <div class="form-group">
                                            <label for="date_debut">Date Début :</label>
                                            <input type="date" class="form-control" name="date_debut" placeholder="aaaa-mm-jj" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="date_fin">Date Fin :</label>
                                            <input type="date" class="form-control" name="date_fin" placeholder="aaaa-mm-jj" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="type">Sélectionner Type :</label>
                                            <select class="form-control" name="type_arret" required>
                                                <option value="conge_annuel">Congés Annuel</option>
                                                <option value="autorisation_exceptionnelle">Autorisation Exceptionnelle</option>
                                                <option value="autorisation_maladie">Autorisation Maladie</option>
                                            </select>
                                        </div>
                                        <input type="text" name="status_arret" value="Attente Validation Chef" hidden="true">

                                        <button type="submit" class="btn btn-success">Envoyer Demande</button>
                                        <button type="reset" class="btn btn-danger">Annuler Demande</button>
                                    </form>
                                    <div>
                                        <br>
                                        <br>
                                        <h4 class="text-danger"> <c:out value="${param.erreur}"/></h4>
                                        <h4 class="text-danger"> <c:out value="${param.refus}"/></h4>
                                        <h4 class="text-success"> <c:out value="${param.confirmation}"/></h4>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="conges" class="tab-pane">
                        <h1>Congés</h1>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Date Début</th>
                                        <th>Date Fin</th>
                                        <th>Durée</th>
                                        <th>Prêt</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <sql:query dataSource="${dataSource}" var="result">
                                        select *
                                        from arret a, employe e
                                        where a.cin_employe=? and a.type_arret=? and a.cin_employe = e.cin_employe
                                        order by num_arret desc;
                                        <sql:param value="${param.cin_employe}"></sql:param>
                                        <sql:param value="conge_annuel"></sql:param>
                                    </sql:query>
                                    <c:forEach var="row" items="${result.rows}">
                                        <tr class="${row.status_arret}">
                                            <td><c:out value="${row.num_arret}" /></td>
                                            <td><c:out value="${row.date_debut}" /></td>
                                            <td><c:out value="${row.date_fin}" /></td>
                                            <td>
                                                <jsp:useBean id="arret" class="com.RHmanager.org.Arret" scope="request" />
                                                <jsp:setProperty name="arret" property="date_debut" value="${row.date_debut}"/>
                                                <jsp:setProperty name="arret" property="date_fin" value="${row.date_fin}"/>
                                                <jsp:getProperty name="arret" property="duration"/>

                                            </td>
                                            <td><c:out value="${row.pret_conge}" /></td>
                                            <td><c:out value="${row.status_arret}" /></td>
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
                                        <th>Date Début</th>
                                        <th>Date Fin</th>
                                        <th>Durée</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <sql:query dataSource="${dataSource}" var="result">
                                        select * from arret where cin_employe=? and type_arret=?
                                        <sql:param value="${param.cin_employe}"></sql:param>
                                        <sql:param value="autorisation_maladie"></sql:param>
                                    </sql:query>
                                    <c:forEach var="row" items="${result.rows}">
                                        <tr class="${row.status_arret}">
                                            <td><c:out value="${row.num_arret}" /></td>
                                            <td><c:out value="${row.date_debut}" /></td>
                                            <td><c:out value="${row.date_fin}" /></td>
                                            <td>
                                                <jsp:useBean id="arret_mala" class="com.RHmanager.org.Arret" scope="request" />
                                                <jsp:setProperty name="arret_mala" property="date_debut" value="${row.date_debut}"/>
                                                <jsp:setProperty name="arret_mala" property="date_fin" value="${row.date_fin}"/>
                                                <jsp:getProperty name="arret_mala" property="duration"/>

                                            </td>
                                            <td><c:out value="${row.status_arret}" /></td>
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
                                        <th>Date Debut</th>
                                        <th>Date Fin</th>
                                        <th>Durée</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <sql:query dataSource="${dataSource}" var="result">
                                        select * from arret where cin_employe=? and type_arret=?
                                        <sql:param value="${param.cin_employe}"></sql:param>
                                        <sql:param value="autorisation_exceptionnelle"></sql:param>
                                    </sql:query>
                                    <c:forEach var="row" items="${result.rows}">
                                        <tr class="${row.status_arret}">
                                            <td><c:out value="${row.num_arret}" /></td>
                                            <td><c:out value="${row.date_debut}" /></td>
                                            <td><c:out value="${row.date_fin}" /></td>
                                            <td>
                                                <jsp:useBean id="arret_auto" class="com.RHmanager.org.Arret" scope="request" />
                                                <jsp:setProperty name="arret_auto" property="date_debut" value="${row.date_debut}"/>
                                                <jsp:setProperty name="arret_auto" property="date_fin" value="${row.date_fin}"/>
                                                <jsp:getProperty name="arret_auto" property="duration"/>
                                            </td>
                                            <td><c:out value="${row.status_arret}" /></td>
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