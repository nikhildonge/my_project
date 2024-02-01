package com.springinitializr.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller

public class TestController {
	
	@RequestMapping("/test")
	@ResponseBody
	public String Test() {
		return "Welcome to My Page";
	}

}
