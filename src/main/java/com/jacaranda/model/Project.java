package com.jacaranda.model;

import java.util.List;
import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="project")
public class Project {
	@Id
	private int id;
	private String name;
	private String butget;
	
	@OneToMany(mappedBy="project")
	List<CompanyProject> companyProject;
	
	@OneToMany(mappedBy="project")
	private List<EmployeeProject> employeeProjects;

	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getButget() {
		return butget;
	}
	public void setButget(String butget) {
		this.butget = butget;
	}
	
	
	public List<EmployeeProject> getEmployeeProjects() {
		return employeeProjects;
	}
	public void setEmployeeProjects(List<EmployeeProject> employeeProjects) {
		this.employeeProjects = employeeProjects;
	}
	public List<CompanyProject> getCompanyProject() {
		return companyProject;
	}
	public void setCompanyProject(List<CompanyProject> companyProject) {
		this.companyProject = companyProject;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Project other = (Project) obj;
		return id == other.id;
	}
	
	
	
	
	

}
