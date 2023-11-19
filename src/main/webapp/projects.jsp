<%@page import="java.time.temporal.ChronoUnit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jacaranda.model.Employee" %>
<%@ page import="com.jacaranda.model.Company" %>
<%@ page import="com.jacaranda.model.Project" %>
<%@ page import="com.jacaranda.model.CompanyProject" %>
<%@ page import="com.jacaranda.model.EmployeeProject" %>
<%@ page import="com.jacaranda.repository.DbRepository" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDateTime" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Projects</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<%
try {
    // Obtener el empleado actual a partir del ID de sesión
    Employee emp = DbRepository.find(Employee.class, Integer.parseInt((String) session.getAttribute("id")));
    
    // Obtener la lista de proyectos de la empresa desde la base de datos
    ArrayList<CompanyProject> listCompanyProject = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);

	 // Mapa para almacenar el tiempo de inicio de cada proyecto
    Map<Integer, LocalDateTime> mapaTime = session.getAttribute("sessionMapTime") == null ? new HashMap<>() : (HashMap) session.getAttribute("sessionMapTime");
    
    // Verificar si se hizo clic en el botón "Start Project"
    if (request.getParameter("start") != null) {
        // Obtener la hora de inicio actual
        LocalDateTime startTime = LocalDateTime.now();
        int projectId = Integer.valueOf(request.getParameter("start"));
        
        // En el mapa almacenas como clave el id del proyecto con su respectivo valor de tiempo
        mapaTime.put(projectId, startTime);
        
        //Creas una session del mapa 
        session.setAttribute("sessionMapTime", mapaTime);
  
       
        // Si se hizo clic en el botón "Stop Project"
    } else if (request.getParameter("stop") != null) {
        // Obtener la hora de finalización actual
        LocalDateTime endTime = LocalDateTime.now();
        // Obtener el ID del proyecto 
        Project projectId = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("stop")));
        
     	// Obtener la hora de inicio asociada con el proyecto que se detuvo desde el mapa
        LocalDateTime startTime = mapaTime.get(Integer.valueOf(request.getParameter("stop")));
     	
        // Calcular el tiempo transcurrido en segundos, entre el comienzo y el final 
        int totalTime = (int) ChronoUnit.SECONDS.between(startTime, endTime);
        
        // Verificar si el proyecto existe
        if (projectId != null) {
            // Crear un objeto EmployeeProject con la información del proyecto, empleado y tiempo
            EmployeeProject ep = new EmployeeProject(projectId, emp, totalTime);

            // Buscar un registro existente para el proyecto y empleado actuales
            EmployeeProject existingRegistration = DbRepository.find(EmployeeProject.class, ep);

            // Verificar si ya existe un registro para este proyecto y empleado
            if (existingRegistration != null) {
                // Si existe, agregar el tiempo al tiempo existente
                existingRegistration.setTime(existingRegistration.getTime() + totalTime);
                // Actualizar el registro en la base de datos
                DbRepository.edit(existingRegistration);
            } else {
                // Si no existe un registro, agregar uno nuevo a la base de datos
                ep.setTime(totalTime);
                DbRepository.add(ep);
            }
         	// Eliminar el registro del proyecto que se detuvo del mapa
            mapaTime.remove(Integer.valueOf(request.getParameter("stop")));
        }
    }
%>
    <table class="table">
        <thead>
            <tr>
                <td scope="col"> Nombre del Proyecto</td>
            </tr>
        </thead>
        <tbody>
            <%
            for (CompanyProject cp : listCompanyProject) {
                if (cp.getCompany().getId() == emp.getCompany().getId()) {
            %>
           <tr>
           <td><%=cp.getProject().getName()%></td>
            <td>    
                <form>
                    <%
                    if(!mapaTime.containsKey(cp.getProject().getId())){
                        %>
                        <button name="start" value="<%=cp.getProject().getId()%>" type="submit" class="btn btn-success">Start Project</button>
                    <%
                    } else {
                        %>
                        <button name="stop" value="<%=cp.getProject().getId()%>" type="submit" class="btn btn-warning">Stop Project</button>    
                    <%
                    }
                    %>
                </form>    
            </td>
           </tr>    
            <% }
            }
            %>  
        </tbody>
    </table>
<%
} catch (Exception e) {
    response.sendRedirect("error.jsp?msg=Se ha producido un error: " + e.getMessage());
}
%>
</body>
</html>
