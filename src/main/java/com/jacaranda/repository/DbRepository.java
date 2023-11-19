package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jacaranda.model.Company;
import com.jacaranda.model.Employee;
import com.jacaranda.model.EmployeeProject;
import com.jacaranda.utility.DbUtility;


public class DbRepository {
	
	public static <E> E find(Class<E> c, int id) throws Exception {
		// Declaración de variables locales
	
		Session session; // Objeto de sesión para la base de datos
		E result = null; // Variable para almacenar el resultado de la búsqueda

		try {
			// Intento abrir una nueva sesión utilizando la fábrica de sesiones de DbUtility
			session = DbUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			// Si ocurre alguna excepción, lanzar una nueva excepción con un mensaje específico
			throw new Exception("Error en la base de datos");
		}

		try {
			result = session.find(c, id);//Clase de la entidad y la primary key 
		} catch (Exception e) {
			// En caso de que ocurra una excepción, no se realiza ninguna acción específica en este bloque
			throw new Exception("Error al obtener la entidad");
		}

		// Devolver el resultado de la operación de búsqueda, que podría ser null si no se encuentra ningún resultado
		return result;
	}
	
	public static <E> E find(Class<E> c, E object) throws Exception {
		
		// Declaración de variables locales
		Session session; // Objeto de sesión para la base de datos
		E result = null; // Variable para almacenar el resultado de la búsqueda

		try {
			// Intento abrir una nueva sesión utilizando la fábrica de sesiones de DbUtility
			session = DbUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			// Si ocurre alguna excepción, lanzar una nueva excepción con un mensaje específico
			throw new Exception("Error en la base de datos");
		}

		try {
			result = session.find(c, object);//Clase de la entidad
		} catch (Exception e) {
			// En caso de que ocurra una excepción, no se realiza ninguna acción específica en este bloque
			throw new Exception("Error al obtener la entidad");
		}

		// Devolver el resultado de la operación de búsqueda, que podría ser null si no se encuentra ningún resultado
		return result;
	}
	
	public static <E> List<E> findAll(Class<E> c) throws Exception {
		// Declaración de variables 
		
		Session session = null; 
		List<E> resultList = null; 

		try {
			// Intento abrir una nueva sesión utilizando la fábrica de sesiones de DbUtility
			session = DbUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			// Si ocurre alguna excepción, lanzar una excepción con un mensaje
			throw new Exception("Error en la base de datos " + e.getMessage());
		}

		try {
			// Se intenta obtener todos los registros de la entidad específica mediante una consulta
			resultList = (List<E>) session.createSelectionQuery("From " + c.getName()).getResultList(); 
		} catch (Exception e) {
			// Si ocurre alguna excepción al obtener los registros, se lanza una excepción
			throw new Exception("Error al obtener la lista de la entidad");
		}

		// Se devuelve la lista de resultados obtenida de la base de datos
		return resultList;
	}
	
	public static <E> void add(E entity) throws Exception {
	    
	    Transaction transaction = null;
	    Session session = null; 
	    
		    try {
				session = DbUtility.getSessionFactory().openSession();
				transaction = session.beginTransaction();
				
			} catch (Exception e) {
				// Si ocurre alguna excepción, lanza una excepción con un mensaje
				throw new Exception("Error en la base de datos " + e.getMessage());
			}
	        
	        try {
	            session.persist(entity);
	            transaction.commit();
	        } catch (Exception e) {
	            transaction.rollback();
	            System.out.println(e.getMessage());
	        }
	        session.close();
	}
	
	
	public static <E> void remove (E entity) throws Exception {
		
		Transaction transaction = null;
		Session session = null; 
		
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
			
		} catch (Exception e) {
			// Si ocurre alguna excepción, lanza una excepción con un mensaje
			throw new Exception("Error en la base de datos" + e.getMessage());
		}
		
		try {
			session.remove(entity);
			transaction.commit();
			
		}catch (Exception e) {
			transaction.rollback();
			System.out.println(e.getMessage());
		}
		session.close();

	}
	
	public static <E> void edit (E entity) throws Exception {
		Transaction transaction = null;
		Session session = null; 
		
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
			
		} catch (Exception e) {
			// Si ocurre alguna excepción, lanza una excepción con un mensaje
			throw new Exception("Error en la base de datos" + e.getMessage());
		}
		
		try {
			session.merge(entity);
			transaction.commit();
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	
	

}
