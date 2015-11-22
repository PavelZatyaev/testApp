package ru.bezslovarya.test_task.dao;

import java.util.List;
import java.util.Map;

//import ru.bezslovarya.test_task.domain.Message;
import ru.bezslovarya.test_task.domain.User;


public interface UserDAO {
	
	public List<User> listUser();

	public Map<Integer, String> mapUserName(String username);
	
//	public String getUserFIO(Integer id);
	
	public void addUser(User user);

	public void removeUser(Integer id);
}
