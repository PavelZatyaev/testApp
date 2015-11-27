package ru.bezslovarya.test_task.services;

import java.util.List;

//import org.springframework.security.access.annotation.Secured;

import ru.bezslovarya.test_task.domain.Message;

public interface MessageService {
	
	public void addMessage(Message message);
	
//	@Secured({"ROLE_ADMIN","ROLE_USER"})
	public List<Message> listMessage(Integer id);

	public void removeMessage(Integer id);
	

}
