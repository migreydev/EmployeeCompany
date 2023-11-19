<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jacaranda.model.Employee" %>
<%@ page import="com.jacaranda.model.Company" %>
<%@ page import="java.util.ArrayList, java.time.LocalDate, java.sql.Date" %>
<%@ page import="com.jacaranda.repository.DbRepository" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Employee</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<%
    ArrayList<Company> listCompany = (ArrayList<Company>) DbRepository.findAll(Company.class);
	Employee emp = null;
	String editButton = request.getParameter("editButton");
	
	if(editButton != null){
		try {
			int employeeId = Integer.parseInt(request.getParameter("employeeId"));
			emp = DbRepository.find(Employee.class, employeeId);
	
			if (emp != null) {
				String firstName = request.getParameter("name");
				String lastName = request.getParameter("lastName");
				String email = request.getParameter("email");
				String gender = request.getParameter("gender");
				Date birthDate = Date.valueOf(request.getParameter("birth"));
				
				int companyId = Integer.parseInt(request.getParameter("company"));
				Company selectedCompany = DbRepository.find(Company.class, companyId);
				
				emp.setFirstName(firstName);
				emp.setLastName(lastName);
				emp.setEmail(email);
				emp.setGender(gender);
				emp.setDateOfBirth(birthDate);
				emp.setCompany(selectedCompany);
	
				DbRepository.edit(emp); 
			
				%>
				<p>It was edited successfully!</p>
				<%
			} else {
				%>
				<p>Error: Employee not found.</p>
				<%
			}
		} catch (Exception e) {
			out.print(e.getMessage());
		}
	}
%>

<div class="container" align="center">
    <form>
        <% if (emp != null) { %>
            <input class="nombre" type="text" name="name" value="<%=emp.getFirstName() %>" >
            <br><br>

            <input class="lastName" type="text" name="lastName" value="<%=emp.getLastName() %>" >
            <br><br>

            <input class="email" type="email" name="email" value="<%=emp.getEmail() %>" >
            <br><br>

            <select class="gender" name="gender">
                <option value="male">Male</option>
                <option value="female">Female</option>
            </select>
            <br><br>

            <input class="birth" type="date" name="birth" value="<%=emp.getDateOfBirth() %>">
            <br><br>

            <select class="company" name="company">
                <% for (Company c : listCompany) { %>
                    <option value="<%= c.getId() %>"><%= c.getName() %></option>
                <% } %>
            </select>
            <br><br>

            <input type="hidden" name="employeeId" value="<%= emp.getId() %>">
            <button name="editButton" type="submit" class="btn btn-secundary">Edit</button>
        <% } else { %>
            <p>Error: Employee not found.</p>
        <% } %>
    </form>
</div>
</body>
</html>
