package com.task.sunbase.controller;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
@RequestMapping("/abc")
public class CustomerController {

    @Autowired
    private CustomerService customerService;
    
    @GetMapping
	public String getUsers() {
		return "get usget users was calleders was called";
	}
    

    @PostMapping("/saveCustomer")
    public int saveCustomers(@RequestBody Customer cust) {
        System.out.println("I'm in ");
        customerService.createCustomer(cust);
        return cust.getId();
    }
    
    @PostMapping("/saveUser")
    public int saveUser(@RequestBody UserReg userReg) {
    	System.out.println("I'm in Registered");
    	customerService.createUser(userReg);
    	return userReg.getId();
    }
    
	/*
	 * @PostMapping("/login") public String login(@RequestBody UserReg user) {
	 * String email = user.getEmail(); String password = user.getPassword();
	 * 
	 * // Perform validation, authentication, etc. UserReg user1 =
	 * customerService.findByEmailAndPassword(email, password);
	 * System.out.println("im in user1 "+user1); if (user1 != null) {
	 * System.out.println("im in login"); return "Login successful!"; } else {
	 * System.out.println("im in login else"); return "Invalid credentials!"; } }
	 */
    
    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody UserReg user) {
        String email = user.getEmail();
        String password = user.getPassword();

        // Perform validation, authentication, etc.
        UserReg user1 = customerService.findByEmailAndPassword(email, password);

        if (user1 != null) {
        	String successMessage = "Login successful!";
            System.out.println("Server response: " + successMessage);
            return ResponseEntity.ok(successMessage);
        } else {
        	 String errorMessage = "Invalid credentials!";
             System.out.println("Server response: " + errorMessage);
             return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorMessage);
        }
    }


    
	/*
	 * public String login1(@RequestBody UserReg user) {
	 * System.out.println("im in login");
	 * if(customerService.existsByEmail(user.getEmail())) {
	 * System.out.println("im in existsByEmail");
	 * if(customerService.existsByPassword(user.getPassword())) {
	 * System.out.println("im in existsByPassword"); return "student Exists"; }
	 * return "Incorrect Password"; } return
	 * "Student doesn't exist with this email id:- " + user.getEmail() ; }
	 */
    
    @PutMapping("/updateCustomer/{id}")
	public void updateCustomer(@PathVariable int id, @RequestBody Customer cust) {
    	customerService.updateCourse(id,cust);
	}
    
	
	  @GetMapping("/getAllCustomer")
	  @ResponseBody private List<Customer> getAllCustomer()
	  { 
		  return customerService.getAllCustomer(); 
	  
	  }
	
    
	  @RequestMapping("/getLoginPage")
	  public ModelAndView getLoginPage() {
		  ModelAndView modelAndView = new ModelAndView("loginPage");
		  //System.out.println("Hiii iam here");
		  return modelAndView;
	  }
	  
    @RequestMapping("/getMainPage")
    public ModelAndView getMainPage() {
    	 ModelAndView modelAndView = new ModelAndView("mainPage");
    	//System.out.println("Hiii iam here");
    	return modelAndView;
    }
    
	/*
	 * @GetMapping("/getAllCustomer") public ModelAndView getAllCustomer() {
	 * ModelAndView modelAndView = new ModelAndView("customerList"); List<Customer>
	 * customerList = customerService.getAllCustomer();
	 * modelAndView.addObject("customerList", customerList);
	 * 
	 * JSONObject obj = new JSONObject(modelAndView);
	 * System.out.println(obj.toString()); return modelAndView; }
	 */
	
	@GetMapping("/getbyId/{custid}")
	private Customer getCrudById(@PathVariable("custid") int custid ) {
		return customerService.GetcustbyId(custid);
		
	}
	
	@DeleteMapping("/deleteById/{custId}")
	
	private int DeleteById(@PathVariable("custId") int custId) {
		customerService.deleteById(custId);
		
		return custId;
	}
	
	
	@GetMapping("/search")
    public List<Customer> searchCustomers(@RequestParam String column, @RequestParam String value) {
        return customerService.search(column, value);
    }
	
	
	@GetMapping("/searchWithPaginationAndSorting")
    public Page<Customer> searchCustomersWithPaginationAndSorting(@RequestParam String column,@RequestParam String value,Pageable pageable) {
        return customerService.searchWithPaginationAndSorting(column, value, pageable);
    }
    
    
}
