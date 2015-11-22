package ru.bezslovarya.test_task.services;

import java.util.List;
import ru.bezslovarya.test_task.domain.Message;

public interface MessageService {
	
	public void addMessage(Message message);

	public List<Message> listMessage(Integer id);

	public void removeMessage(Integer id);
	

}
