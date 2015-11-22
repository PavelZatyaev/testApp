package ru.bezslovarya.test_task.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ru.bezslovarya.test_task.dao.GroupMemberDAO;
import ru.bezslovarya.test_task.domain.GroupMember;
//import ru.bezslovarya.test_task.domain.User;

@Service
public class GroupMemberServiceImpl implements GroupMemberService {

	@Autowired
    private GroupMemberDAO groupMemberDAO;

	public void addGroupMember(GroupMember groupMember) {
		groupMemberDAO.addGroupMember(groupMember);
	}

	@Transactional
	public List<GroupMember> listGroupMember() {
		return groupMemberDAO.listGroupMember();
	}
	
}
