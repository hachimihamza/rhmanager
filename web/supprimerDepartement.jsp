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
           update employe set num_departement=NULL where num_departement=${param.num_departement}
         </sql:update>
        <sql:update dataSource="${dataSource}" var="result">
           delete from departement where num_departement=${param.num_departement}
         </sql:update>
             <c:if test="${result>=1}">
         
                 <c:redirect url="administrateur.jsp"/>
             </c:if>
    </body>
</html>
