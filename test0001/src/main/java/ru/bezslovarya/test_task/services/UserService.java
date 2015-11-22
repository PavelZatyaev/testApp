package ru.bezslovarya.test_task.services;

import java.util.List;
import java.util.Map;

import org.springframework.security.access.annotation.Secured;

import ru.bezslovarya.test_task.domain.User;

public interface UserService {

	//@Secured("ROLE_ADMIN")
	public List<User> listUser();

	public Map<Integer, String> mapUserName(String username);
	
	public Integer getUserID();
	
//	public String getUserFIO(Integer id);
	
	public void addUser(User user);
	
	public void removeUser(Integer id);
	
	public void addGroup(String username, Boolean isAdmin);
	
//	public Boolean userIsAdmin(String username);
}
