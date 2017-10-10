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

        <sql:setDataSource var="dataSource"
                           driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/rh_database"
                           user="root"
                           password="azerty" />
        <sql:update dataSource="${dataSource}" var="result">
            insert into chef values(?,?,?,?,?,?,NULL,?,NULL,?)
            <sql:param value="${param.cin_chef}"/>
            <sql:param value="${param.nom_chef}"/>
            <sql:param value="${param.prenom_chef}"/>
            <sql:param value="${param.adresse}"/>
            <sql:param value="${param.username}"/>
            <sql:param value="${param.motdepasse}"/>
            <sql:param value="${param.is_admin}"/>
            <sql:param value="${param.date_recrutement}"/>
        </sql:update>
        <sql:update dataSource="${dataSource}" var="result">
            insert into employe values(?,?,?,?,?,?,NULL,?,NULL,?)
            <sql:param value="${param.cin_chef}"/>
            <sql:param value="${param.nom_chef}"/>
            <sql:param value="${param.prenom_chef}"/>
            <sql:param value="${param.adresse}"/>
            <sql:param value="${param.username}"/>
            <sql:param value="${param.motdepasse}"/>
            <sql:param value="${param.is_admin}"/>
            <sql:param value="${param.date_recrutement}"/>
        </sql:update>
        <c:if test="${result>=1}">
            <c:redirect url="administrateur.jsp">
            </c:redirect>
        </c:if>

    </body>
</html>
