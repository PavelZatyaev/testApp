package ru.bezslovarya.test_task.services;

import java.util.List;
import java.util.Map;

import ru.bezslovarya.test_task.domain.User;

public interface AddressService {
	public List<User> listAddress(Integer sender_id);
	public List<User> listAllAddress(Integer sender_id);
	
	public void addAddress(Integer recipient_id, Integer sender_id);

	public void removeAddress(Integer recipient_id, Integer sender_id);
	
	public Map<Integer, String> mapAddress(Integer sender_id);
}
