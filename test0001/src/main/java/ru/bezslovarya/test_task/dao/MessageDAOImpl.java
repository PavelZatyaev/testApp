package ru.bezslovarya.test_task.dao;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import ru.bezslovarya.test_task.domain.Message;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MessageDAOImpl implements MessageDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	public void addMessage(Message message) {
		sessionFactory.getCurrentSession().save(message);
	}

	@SuppressWarnings("unchecked")
	public List<Message> listMessage(Integer id) {
		Query query;
		
		if (id > 0) {
			query = sessionFactory.getCurrentSession().createQuery("select m from Message m where user_from_id = :p_id");
			query.setInteger("p_id", id);
		}
		else 
			query = sessionFactory.getCurrentSession().createQuery("select m from Message m");
		
		return query.list(); 
//
//		return sessionFactory.getCurrentSession().createQuery(
//				"select m from Message m"
//				)				
//			.list();
	}

	public void removeMessage(Integer id) {
		Query query = sessionFactory.getCurrentSession().createQuery("delete from Message where id = :p_id");
		query.setInteger("p_id", id);
		query.executeUpdate();
	}

}
