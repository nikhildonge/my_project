package com.task.sunbase.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.task.sunbase.bean.Customer;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer>, JpaSpecificationExecutor<Customer>{

	
		List<Customer> findByFnameContaining(String fname); 
		List<Customer> findByLnameContaining(String lname);
	 	List<Customer> findByStreetContaining(String street);
	    List<Customer> findByAddressContaining(String address);
	    List<Customer> findByCityContaining(String city);
	    List<Customer> findByStateContaining(String state);
	    List<Customer> findByEmailContaining(String email);
	    List<Customer> findByPhoneContaining(String phone);
	
}
