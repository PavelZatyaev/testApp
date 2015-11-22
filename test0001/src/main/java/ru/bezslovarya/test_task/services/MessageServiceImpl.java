package ru.bezslovarya.test_task.services;

import ru.bezslovarya.test_task.domain.Message;
import ru.bezslovarya.test_task.dao.MessageDAO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MessageServiceImpl implements MessageService{
	
    @Autowired
    private MessageDAO messageDAO;
 
    @Transactional
    public void addMessage(Message message) {
    	messageDAO.addMessage(message);
    }
 
    @Transactional
    public List<Message> listMessage(Integer id) {
 
        return messageDAO.listMessage(id);
    }
 
    @Transactional
    public void removeMessage(Integer id) {
    	messageDAO.removeMessage(id);
    }
	

}
