<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jacaranda.model.Employee" %>
<%@ page import="com.jacaranda.model.Company" %>
<%@ page import="java.util.ArrayList, java.time.LocalDate, java.sql.Date" %>
<%@ page import="com.jacaranda.repository.DbRepository" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<%
    ArrayList<Company> listCompany = (ArrayList<Company>) DbRepository.findAll(Company.class);
    Employee emp = null;

    try {
        String button = request.getParameter("saveButton");

        if (button != null) {
            String nameEmployee = request.getParameter("name");
            String lastNaneEmployee = request.getParameter("lastName");
            String emailEmployee = request.getParameter("email");
            String genderEmployee = request.getParameter("gender");
            Date date = Date.valueOf(request.getParameter("birth"));
            int companyId = Integer.parseInt(request.getParameter("companyId"));
            Company selectedCompany = DbRepository.find(Company.class, companyId);
            String rolEmployee = request.getParameter("rol");
            String password = request.getParameter("password");

            if (password.equals(request.getParameter("repeatPassword"))) {
                emp = new Employee(nameEmployee, lastNaneEmployee, emailEmployee, genderEmployee, date, selectedCompany, rolEmployee, password);
                DbRepository.add(emp);
	%>
                <p>It was added successfully!</p>
	<%
            } else {
	%>
                <p>Error, passwords must be the same!</p>
	<%
            }
        }
    } catch (Exception e) {
	%>
        <p>Error: <%= e.getMessage() %></p>
	<%
    }
	%>

<div class="container" align="center">
    <form>
        <label for="name">Enter your name:</label><br>
        <input class="nombre" type="text" name="name" placeholder="Name" required>
        <br><br>

        <label for="lastName">Enter your last name:</label><br>
        <input class="lastName" type="text" name="lastName" placeholder="Last Name" required>
        <br><br>

        <label for="email">Enter your email:</label><br>
        <input class="email" type="email" name="email" placeholder="Email" required>
        <br><br>

        <label for="gender">Enter your gender:</label><br>
        <select class="gender" name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <br><br>

        <label for="birth">Enter your date of birth:</label><br>
        <input class="birth" type="date" name="birth" required>
        <br><br>

        <select class="company" name="companyId">
            <% for (Company c : listCompany) { %>
                <option value="<%= c.getId() %>"><%= c.getName() %></option>
            <% } %>
        </select>
        <br><br>

        <label for="rol">Enter your rol:</label><br>
        <select class="rol" name="rol" required>
            <option value="User">User</option>
        </select>
        <br><br>

        <label for="password">Enter your password:</label><br>
        <input class="password" type="password" name="password" required>
        <br><br>

        <label for="password">Repeat the password again:</label><br>
        <input class="password" type="password" name="repeatPassword" required>
        <br><br>

        <button name="saveButton" type="submit" class="btn btn-primary">Save</button>
    </form>
</div>
</body>
</html>
