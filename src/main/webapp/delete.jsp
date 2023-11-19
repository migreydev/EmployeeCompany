<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jacaranda.model.Employee" %>
<%@ page import="com.jacaranda.model.Company" %>
<%@ page import="java.util.ArrayList, java.time.LocalDate, java.sql.Date" %>
<%@ page import="com.jacaranda.repository.DbRepository" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Employee</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<%
    ArrayList<Company> listCompany = (ArrayList<Company>) DbRepository.findAll(Company.class);
	Employee emp = new Employee();
	String deleteButton = request.getParameter("delete");
	

	if(deleteButton != null) {
		try {
			int employeeId = Integer.parseInt(request.getParameter("employeeId"));
			emp = DbRepository.find(Employee.class, employeeId);
			DbRepository.remove(emp);
		
		} catch (Exception e){
			out.println(e.getMessage());
		}
	}
%>

<div class="container" align="center">
    <form>
        <input class="nombre" type="text" name="name" value="<%=emp.getFirstName() %>" placeholder="Name" readonly>
        <br><br>

        <input class="lastName" type="text" name="lastName" value="<%=emp.getLastName() %>" placeholder="Last Name" readonly>
        <br><br>

        <input class="email" type="email" name="email" value="<%=emp.getEmail() %>" placeholder="Email" readonly>
        <br><br>

        <select class="gender" name="gender" value="<%=emp.getGender() %>" readonly>
            <option value="male">Male</option>
            <option value="female">Female</option>
        </select>
        <br><br>

        <input class="birth" type="date" name="birth"value="<%=emp.getDateOfBirth() %>" readonly>
        <br><br>

        <select class="company" name="company" value="<%=emp.getCompany() %>" readonly>
            <% for (Company c : listCompany) { %>
                <option value="<%= c.getId() %>"><%= c.getName() %></option>
            <% } %>
        </select>
        <br><br>

        <button name="deleteButton" type="submit" class="btn btn-danger">Delete</button>
    </form>
</div>
</body>
</html>
