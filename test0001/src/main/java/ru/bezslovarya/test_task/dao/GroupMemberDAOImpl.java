package ru.bezslovarya.test_task.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import ru.bezslovarya.test_task.domain.GroupMember;

@Repository
public class GroupMemberDAOImpl  implements GroupMemberDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	public void addGroupMember(GroupMember groupMember) {
		sessionFactory.getCurrentSession().save(groupMember);
	}
	
//	public Boolean userIsAdmin(String username) {
//		return true;
//	}
	
	@SuppressWarnings("unchecked")
	public List<GroupMember> listGroupMember() {

		return sessionFactory.getCurrentSession().createQuery("from GroupMember").list();
	}	

}
