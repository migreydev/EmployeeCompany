<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jacaranda.model.Employee"%>
<%@ page import="com.jacaranda.repository.DbRepository"%>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

<%
    Employee emp = null;
    String password = request.getParameter("password");
    String loginButton = request.getParameter("login");
    String idParam = request.getParameter("id");

    try {
        if (loginButton != null) {
            emp = DbRepository.find(Employee.class, Integer.valueOf(idParam));
            session.setAttribute("id", idParam);
            if (emp != null) {
                if (emp.getRol().equals("admin") && DigestUtils.md5Hex(password).equals(emp.getPassword())) {
                    session.setAttribute("rolSession", "admin");
                    response.sendRedirect("listCompany.jsp");
                } else if (emp.getRol().equals("user") && DigestUtils.md5Hex(password).equals(emp.getPassword())) {
                    session.setAttribute("rolSession", "user");
                    response.sendRedirect("listCompany.jsp");
                }
            } else {
                out.println("User doesn't exist");
            }
        }
    } catch (Exception e) {
        response.sendRedirect("error.jsp?msg=Los datos no son válidos");
    }
%>

<div class="login">
    <div class="form"> 
        <div class="login">
            <div class="login-header" align="center">
                <h3>LOGIN</h3>
                <p>Please enter your credentials to login.</p>
            </div>
        </div>
        <div class="container">
	        <img src="concepto-abstracto-sistema-control-acceso_335657-3180.jpg"></img>
       
	        <form class="login-form" align="center">
	            <input name="username" type="text" placeholder="username" required /><br><br>
	            <input name="password" type="password" placeholder="password" required /><br><br>
	            <input name="id" type="text" placeholder="id" required /><br><br>
	            <button name="login" type="submit" class="btn btn-warning">login</button><br><br>
	        </form>
         </div>
    </div>
</div>
</body>
</html>
