package ru.bezslovarya.test_task.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

//import ru.bezslovarya.test_task.domain.Message;
import ru.bezslovarya.test_task.domain.User;
//import ru.bezslovarya.test_task.domain.GroupMember;
//import ru.bezslovarya.test_task.domain.Message;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;
//import org.springframework.stereotype.Repository;
//import org.springframework.transaction.annotation.Transactional;
//import org.hibernate.Query;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<User> listUser() {

		return sessionFactory.getCurrentSession().createQuery("from User").list();
	}

	@SuppressWarnings("rawtypes")
	public Map<Integer, String> mapUserName(String username) {

		Map<Integer, String> users = new HashMap<Integer, String>();

		String SQL_query = (username != null && !username.isEmpty())
				? "select id, FIO from User where username <> " + "'" + username + "' order by FIO"
				: "select id, username from User";

		Query query = sessionFactory.getCurrentSession().createQuery(SQL_query);

		for (Iterator it = query.iterate(); it.hasNext();) {
			Object[] row = (Object[]) it.next();
			users.put((Integer) row[0], row[1].equals(null) ? "n/a" : row[1].toString());
		}

		return users;
	}
	
	@SuppressWarnings("unchecked")
	private Integer existUser(User user) {
		List<User> users = sessionFactory.getCurrentSession().createQuery("from User").list();
				
		for(User u : users) {
			if (u.getUsername().equals(user.getUsername()) ) return u.getId(); 
		}
		return -1;
	}	
	
	@Transactional
	public void addUser(User user) {
		Integer id = existUser(user);
		if (id > 0) {
			removeUser(id); // удаление из групп на триггере
		}
		sessionFactory.getCurrentSession().save(user);
		sessionFactory.getCurrentSession().flush();
	}
	
	
	public void removeUser(Integer id) {
		// удаление из групп на триггере
		Query query = sessionFactory.getCurrentSession().createQuery("delete from User where id = :p_id");
		query.setInteger("p_id", id);
		query.executeUpdate();
		sessionFactory.getCurrentSession().flush();
	}
}
