<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jacaranda.model.Company"%>
<%@ page import="com.jacaranda.model.Employee"%>
<%@ page import="com.jacaranda.model.CompanyProject"%>
<%@ page import="com.jacaranda.model.Project"%>
<%@ page import="com.jacaranda.repository.DbRepository"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List Company</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<%
    try {
        ArrayList<Company> listCompany = (ArrayList<Company>) DbRepository.findAll(Company.class);
        ArrayList<Employee> listEmployee = (ArrayList<Employee>) DbRepository.findAll(Employee.class);
        ArrayList<Project> listProject = (ArrayList<Project>) DbRepository.findAll(Project.class);
        
        

        for (Company c : listCompany) { %>
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Nombre Empresa</th>
                    <th scope="col">Número de Empleados</th>
                    <th scope="col">Número de Proyectos</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><%= c.getName() %>
      
                   <%  if(session.getAttribute("rolSession").equals("admin")){%>
					    <form action="add.jsp" method="GET">
					       <input name='companyId' type='text' value='<%=c.getId() %>' hidden>
					        <div class="form-group row">
					            <div class="offset-4 col8">        	
					                <button name="addButton" type="submit" class="btn btn-primary">Add Employee</button>
					            </div>
					        </div>
					    </form>
					    <%} %>
					</td>
                    <td><%= c.getEmployees().size() %></td>
                    <td><%= c.getCompanyProjects().size() %></td>
                </tr>
                </tbody>
            </table>

            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Nombre Empleado</th>
                </tr>
                </thead>
                <tbody>
                <% for (Employee e : listEmployee) {
                    if (e.getCompany().equals(c)) { %>
                        <tr>
                            <td><%= e.getFirstName() %></td>
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
                    <% }
                } %>
                </tbody>
            </table>

            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Nombre Proyecto</th>
                </tr>
                </thead>
                <tbody>
                <% for (Project p : listProject) {
                    for (CompanyProject cp : c.getCompanyProjects()) {
                        if (cp.getProject().equals(p)) { %>
                            <tr>
                                <td><%= p.getName() %></td>
                            </tr>
                        <% }
                    }
                } %>
                </tbody>
            </table>
        <% }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>



</body>
</html>
