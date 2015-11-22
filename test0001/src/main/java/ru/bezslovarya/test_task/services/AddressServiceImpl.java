package ru.bezslovarya.test_task.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ru.bezslovarya.test_task.dao.AddressDAO;
import ru.bezslovarya.test_task.domain.User;

@Service
public class AddressServiceImpl implements AddressService {
	
    @Autowired
    private AddressDAO addressDAO;

	
	public List<User> listAddress(Integer sender_id) {
		return addressDAO.listAddress(sender_id);
	}
	
	public List<User> listAllAddress(Integer sender_id) {
		return addressDAO.listAllAddress(sender_id);
	}
	
	public void addAddress(Integer recipient_id, Integer sender_id) {
		addressDAO.addAddress(recipient_id, sender_id);
	}

	public void removeAddress(Integer recipient_id, Integer sender_id) {
		addressDAO.removeAddress(recipient_id, sender_id);
	}
	
	public Map<Integer, String> mapAddress(Integer sender_id) {
		return addressDAO.mapAddress(sender_id);
	}
	

}
