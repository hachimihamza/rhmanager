<%--
    Document   : modifier
    Created on : 15 déc. 2016, 14:59:07
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
            update employe set   nom_employe=? ,
            prenom_employe=? , adresse=? , username=? ,
            motdepasse=? , num_departement=?, is_admin=? where cin_employe=?

            <sql:param value="${param.nom_employe}"/>
            <sql:param value="${param.prenom_employe}"/>
            <sql:param value="${param.adresse}"/>
            <sql:param value="${param.username}"/>
            <sql:param value="${param.motdepasse}"/>
            <sql:param value="${param.num_departement}"/>
            <sql:param value="${param.is_admin}"/>
            <sql:param value="${param.cin_employe}"/>
        </sql:update>
        <c:if test="${result>=1}">

            <c:redirect url="administrateur.jsp"/>
        </c:if>
    </body>
</html>
