package ru.bezslovarya.test_task.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ru.bezslovarya.test_task.dao.UserDAO;
//import ru.bezslovarya.test_task.dao.GroupMemberDAO;

import ru.bezslovarya.test_task.domain.User;
import ru.bezslovarya.test_task.domain.GroupMember;

@Service
public class UserServiceImpl implements UserService {
	
    @Autowired
    private UserDAO userDAO;
    
//	@Autowired
//    private GroupMemberDAO groupMemberDAO;
    
    @Transactional
    public List<User> listUser() {
         return userDAO.listUser();
    }
    
    public Map<Integer, String> mapUserName(String username) {
    	return userDAO.mapUserName(username);
    }
    
    public String getUserPassword(User user) {
    	return userDAO.passwordUser(user);
    }

    // и почему security по id не работает ???
    public Integer getUserID() {
    	Map<Integer, String> users= mapUserName(null);
    	
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
		for (Map.Entry<Integer, String> u : users.entrySet()) {
		    if(u.getValue().equals(userDetails.getUsername())) {
		    	return u.getKey();
		    }
		}
		return -1;
    } 
    
    @Autowired	
	private GroupMemberService groupMemberService;
    
    @Transactional
    public void addUser(User user) {
    	userDAO.addUser(user);

    	GroupMember groupMember = new GroupMember ();
    	groupMember.setUsername(user.getUsername());
    	groupMember.setGroup_id(user.getIsAdmin() ? 2 : 1);
    	groupMemberService.addGroupMember(groupMember);
    	
    }
    
    @Transactional
    public void removeUser(Integer id) {
    	userDAO.removeUser(id);
    }
    
    // заглушка для проверки роли 
    public void adminOnly() {
    	return;
    }
    
}


