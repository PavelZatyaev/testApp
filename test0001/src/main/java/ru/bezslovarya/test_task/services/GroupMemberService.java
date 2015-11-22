package ru.bezslovarya.test_task.services;

import java.util.List;

import ru.bezslovarya.test_task.domain.GroupMember;

public interface GroupMemberService {
	
	public void addGroupMember(GroupMember groupMember);
	
	public List<GroupMember> listGroupMember();

}
