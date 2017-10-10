<%--
    Document   : ajouterEmploye
    Created on : 15 déc. 2016, 20:27:30
    Author     : SaiD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

        <sql:setDataSource var="dataSource"
                           driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/rh_database"
                           user="root"
                           password="azerty" />

        <jsp:useBean id="arret" class="com.RHmanager.org.Arret" scope="request" />
        <fmt:parseDate value="${param.date_recrutement}" var="date_recrutement" pattern="yyyy-MM-dd" />
        <jsp:setProperty name="arret" property="date_recrutement" value="${date_recrutement}"/>

        <jsp:setProperty name="arret" property="pret_conge" value="0"/>

        <sql:update dataSource="${dataSource}" var="result">
            insert into employe values(?,?,?,?,?,?,?,?,?,?)
            <sql:param value="${param.cin_employe}"/>
            <sql:param value="${param.nom_employe}"/>
            <sql:param value="${param.prenom_employe}"/>
            <sql:param value="${param.adresse}"/>
            <sql:param value="${param.username}"/>
            <sql:param value="${param.motdepasse}"/>
            <sql:param value="${param.num_departement}"/>
            <sql:param value="${param.is_admin}"/>
            <sql:param value="${arret.pret_conge}"/>
            <sql:param value="${param.date_recrutement}"/>
        </sql:update>

        <c:if test="${result>=1}">
            <c:redirect url="administrateur.jsp" >
            </c:redirect>
        </c:if>

    </body>
</html>
