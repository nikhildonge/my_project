package com.task.sunbase.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.task.sunbase.bean.UserReg;

@Repository
public interface UserRepository extends JpaRepository<UserReg, Integer> {
	
	
	@Query("SELECT u FROM UserReg u WHERE u.email = :email AND u.password = :password") 
	UserReg checkEmailAndPassword(@Param("email") String email, @Param("password") String password);
	
}
