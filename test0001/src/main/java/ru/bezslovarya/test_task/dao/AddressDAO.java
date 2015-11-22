package ru.bezslovarya.test_task.dao;

import ru.bezslovarya.test_task.domain.User;

import java.util.List;
import java.util.Map;

public interface AddressDAO {
	
	public List<User> listAddress(Integer sender_id);
	public List<User> listAllAddress(Integer sender_id);
	
	public void addAddress(Integer recipient_id, Integer sender_id);

	public void removeAddress(Integer recipient_id, Integer sender_id);
	public Map<Integer, String> mapAddress(Integer sender_id);

}
