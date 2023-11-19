<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.jacaranda.model.Employee"%>
    <%@ page import="com.jacaranda.model.Company"%>
    <%@ page import="com.jacaranda.repository.DbRepository"%>
    <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List Employee</title>

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

	
	<%
	    String rolSession = (String) session.getAttribute("rolSession");
	    if (rolSession == null || !rolSession.equals("admin")) {
	        response.sendRedirect("login.jsp");
	        return;
	    }
	%>

		<%
	    ArrayList<Employee> result = new ArrayList<Employee>();
		
	
	    try {
	        // Intenta obtener la lista de empleados de la base de datos
	        result = (ArrayList<Employee>) DbRepository.findAll(Employee.class);
	    } catch (Exception e){
	        // Manejar la excepción de manera adecuada
	    	out.println(e.getMessage());
	    }
	%>
	
	<table class="table">
	    <thead>
	        <tr>
	            <td scope="col">Id</td>
	            <td scope="col">Nombre</td>
	            <td scope="col">Apellidos</td>
	            <td scope="col">Email</td>
	            <td scope="col">Género</td>
	            <td scope="col">Fecha de nacimiento</td>
	            <td scope="col">Nombre de compañia</td>
	            <td scope="col">Rol</td>
	            <td scope="col">Contraseña</td>
	            
	        </tr>
	    </thead>
	    <tbody>
	        <% for (Employee e : result) { %>
	            <tr>
	                <td><%= e.getId() %></td>
	                <td><%= e.getFirstName() %></td>
	                <td><%= e.getLastName() %></td>
	                <td><%= e.getEmail() %></td>
	                <td><%= e.getGender() %></td>
	                <td><%= e.getDateOfBirth() %></td>
	                <td><%= e.getCompany().getName() %></td>
	                <td><%= e.getRol() %></td>
	                <td><%= e.getPassword() %></td>
	                
	                <td>
					    <form action="edit.jsp" method="GET">
					        <input name='employeeId' type='text' value='<%= e.getId() %>' hidden>
					        <div class="form-group row">
					            <div class="offset-4 col8">        	
					                <button name="editButton" type="submit" class="btn btn-warning">Edit</button>
					            </div>
					        </div>
					    </form>
					</td>
					<td>

		                <form action="delete.jsp">
		                <input name='employeeId' type='text' value='<%= e.getId() %>' hidden>
		                <input name='fName' type='text' value='<%= e.getFirstName()  %>' hidden>
		                <input name='lName' type='text' value='<%= e.getLastName() %>' hidden>
		                <input name='email' type='text' value='<%= e.getEmail() %>' hidden>
		                <input name='gender' type='text' value='<%= e.getGender()  %>' hidden>
		                <input name='date' type='text' value='<%= e.getDateOfBirth() %>' hidden>
		                <input name='companyName' type='text' value='<%= e.getCompany().getName() %>' hidden>
		                <input name='rol' type='text' value='<%= e.getRol() %>' hidden>
		                <input name='password' type='text' value='<%= e.getPassword() %>' hidden>
		                	
		                	<div class="form-group row">
			                    <div class="offset-4 col8">        	
			                       <button name="delete" type="submit" class="btn btn-danger">Delete</button>
			               		</div>
			               </div>
		                </form>
	                </td>
	                
	                <td>
	                	<form action="projects.jsp" method="GET">
	                		<input name='employeeId' type='text' value='<%= e.getId() %>' hidden>
	                		<div class="form-group row">
					            <div class="offset-4 col8">        	
					                <button name="projectButton" type="submit" class="btn btn-primary">Projects</button>
					            </div>
					        </div>
	                	</form>
	                
	                </td>
	              </tr>          
	    <% } %>
	    </tbody>
	</table>
</body>
</html>
