package ru.bezslovarya.test_task.dao;

import java.util.List;
import ru.bezslovarya.test_task.domain.Message;

public interface MessageDAO {
	public void addMessage(Message message);

	public List<Message> listMessage(Integer id);

	public void removeMessage(Integer id);

}
