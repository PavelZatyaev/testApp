package ru.bezslovarya.test_task.dao;

//import java.util.ArrayList;
import java.util.HashMap;
//import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ru.bezslovarya.test_task.domain.User;
import ru.bezslovarya.test_task.domain.Address;

@Repository
public class AddressDAOImpl implements AddressDAO {
	
	@Autowired
	private SessionFactory sessionFactory;	
	
	@SuppressWarnings("unchecked")
	public List<User> listAddress(Integer sender_id) {
		Query query = sessionFactory.getCurrentSession()
				.createQuery("select a.user_to from Address a where a.user_sender_id = :p_sender_id");
		query.setInteger("p_sender_id", sender_id);
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<User> listAllAddress(Integer sender_id) {
		Query query = sessionFactory.getCurrentSession()
		.createQuery("from User where id <> :p_sender_id and id not in "
				+ "(select a.user_recipient_id from Address a where a.user_sender_id = :p_sender_id)");
		query.setInteger("p_sender_id", sender_id);
		return query.list();
	}
	
	public Map<Integer, String> mapAddress(Integer sender_id) {
		List<User> ul = listAddress(sender_id);
		Map<Integer, String> users = new HashMap<Integer, String>();
		for (User u : ul) users.put(u.getId(),u.getFIO());
		return users;
	}
	
	
	public void addAddress(Integer recipient_id, Integer sender_id) {
		Address address = new Address();
		address.setUser_recipient_id(recipient_id);
		address.setUser_sender_id(sender_id);
		
		sessionFactory.getCurrentSession().save(address);
		sessionFactory.getCurrentSession().flush();		
	}

	public void removeAddress(Integer recipient_id, Integer sender_id) {
		Query query = sessionFactory.getCurrentSession()
				.createQuery("delete from Address where user_sender_id = :p_sender_id and user_recipient_id = :p_recipient_id");
		query.setInteger("p_sender_id", sender_id);
		query.setInteger("p_recipient_id", recipient_id);		
		query.executeUpdate();
		sessionFactory.getCurrentSession().flush();
	}	
	

}
