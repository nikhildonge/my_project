package com.task.sunbase.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.task.sunbase.bean.Customer;
import com.task.sunbase.bean.UserReg;
import com.task.sunbase.repository.CustomerRepository;
import com.task.sunbase.repository.UserRepository;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;

@Service
public class CustomerService {
	
	@Autowired
    private CustomerRepository customerRepository;
	@Autowired
	private UserRepository userRepo;

	
	// User Registration
		public void createUser(UserReg userReg) {
			// TODO Auto-generated method stub
			userRepo.save(userReg);
		}

		
		// User Login
		public UserReg findByEmailAndPassword(String email, String password) {
	        return userRepo.checkEmailAndPassword(email, password);
	    }
	
	//createCustomer
	 public void createCustomer(Customer customer) {
	         customerRepository.save(customer);
	    }

//updateCourse
	public void updateCourse(int id, Customer cust) {
		// TODO Auto-generated method stub
		
		customerRepository.save(cust);
		
	}


	// getAllCustomer
	public List<Customer> getAllCustomer() {
		// TODO Auto-generated method stub
		List<Customer> custs = new ArrayList<Customer>();
		customerRepository.findAll().forEach(e->custs.add((Customer) e));
		return custs;
	}


	//GetcustbyId
	public Customer GetcustbyId(int custid) {
		// TODO Auto-generated method stub
		
		return (Customer) customerRepository.findById(custid).get();
		
	}


	//deleteById
	public void deleteById(int custId) {
		// TODO Auto-generated method stub
		customerRepository.deleteById(custId);
	}
	 

	//searching
	public List<Customer> search(String column, String value) {
        switch (column) {
		
		case "fname": 
			return
		customerRepository.findByFnameContaining(value); 
		case "lname":
			return 
				customerRepository.findByLnameContaining(value);
        case "street":
            return customerRepository.findByStreetContaining(value);
        case "address":
            return customerRepository.findByAddressContaining(value);
        case "city":
            return customerRepository.findByCityContaining(value);
        case "state":
            return customerRepository.findByStateContaining(value);
        case "email":
            return customerRepository.findByEmailContaining(value);
        case "phone":
            return customerRepository.findByPhoneContaining(value);

            default:
                throw new IllegalArgumentException("Invalid search column: " + column);
        }
    }

}
