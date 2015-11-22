package ru.bezslovarya.test_task.dao;

import java.util.List;

import ru.bezslovarya.test_task.domain.GroupMember;
//import ru.bezslovarya.test_task.domain.User;

public interface GroupMemberDAO {

	public void addGroupMember(GroupMember groupMember);
	
//	public Boolean userIsAdmin(String username);
	
	public List<GroupMember> listGroupMember();
}
