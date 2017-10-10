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
            insert into arret values(?,?,?,?,?,?)
            <sql:param value="${param.num_arret}"/>
            <sql:param value="${param.date_debut}"/>
            <sql:param value="${param.date_fin}"/>
            <sql:param value="${param.type_arret}"/>
            <sql:param value="attente_val_chef"/>
            <sql:param value="${param.cin_employe}"/>
        </sql:update>
        <c:if test="${result>=1}">
            <c:redirect url="employe.jsp?cin_employe=${param.cin_employe}" >

            </c:redirect>
        </c:if>

    </body>
</html>
