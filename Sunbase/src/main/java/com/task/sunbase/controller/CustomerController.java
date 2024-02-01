package com.task.sunbase.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.task.sunbase.bean.Customer;
import com.task.sunbase.bean.UserReg;
import com.task.sunbase.service.CustomerService;

@RestController
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;
    
  
	// for login page
    @RequestMapping("/getLoginPage")
	  public ModelAndView getLoginPage() {
		  ModelAndView modelAndView = new ModelAndView("loginPage");
		  return modelAndView;
	  }
	  
	    // for after login page
	  @RequestMapping("/getMainPage")
	  public ModelAndView getMainPage() {
	  	 ModelAndView modelAndView = new ModelAndView("mainPage");
	  	return modelAndView;
	  }
	  
	  // for User Registration
	  @PostMapping("/saveUser")
	    public int saveUser(@RequestBody UserReg userReg) {
	    	customerService.createUser(userReg);
	    	return userReg.getId();
	    }
	  

	    //for login
	    @PostMapping("/login")
	    public ResponseEntity<Map<String, String>> login(@RequestBody UserReg user) {
	        String email = user.getEmail();
	        String password = user.getPassword();
	        
	        UserReg user1 = customerService.findByEmailAndPassword(email, password);
	        
	        Map<String, String> response = new HashMap<>();
	        if (user1 != null) {
	            response.put("status", "Login successful!");
	            System.out.println("Server response: Login successful!");
	            return ResponseEntity.ok(response);
	        } else {
	            response.put("status", "Invalid credentials!");
	            System.out.println("Server response: Invalid credentials!");
	            return ResponseEntity.ok(response);
	        }
	    }
    
		  // for saveCustomer
	    @PostMapping("/saveCustomer")
	    public int saveCustomers(@RequestBody Customer cust) {
	        System.out.println("I'm in ");
	        customerService.createCustomer(cust);
	        return cust.getId();
	    }
       
	    // Fetch getAllCustomer
	  @GetMapping("/getAllCustomer")
	  @ResponseBody private List<Customer> getAllCustomer()
	  { 
		  return customerService.getAllCustomer(); 
	  
	  }
	
	// Fetch getByIdCustomer
	@GetMapping("/getbyId/{custid}")
	private Customer getCrudById(@PathVariable("custid") int custid ) {
		return customerService.GetcustbyId(custid);
		
	}
	
	// Delete ByIdCustomer
	@DeleteMapping("/deleteById/{custId}")
	
	private int DeleteById(@PathVariable("custId") int custId) {
		customerService.deleteById(custId);
		
		return custId;
	}
	
	// For Searching
	@GetMapping("/search")
    public List<Customer> searchCustomers(@RequestParam String column, @RequestParam String value) {
        return customerService.search(column, value);
    }
	
	
    
}
