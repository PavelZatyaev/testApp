package ru.bezslovarya.test_task.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "address_book")
public class Address {
	
	@Id
	@Column(name = "ID")
	@GeneratedValue
	private Integer id;
	
	@Column(name = "USER_SENDER_ID")
	private Integer user_sender_id;

	@Column(name = "USER_RECIPIENT_ID")
	private Integer user_recipient_id;
	
	@ManyToOne
	@JoinColumn(name = "USER_SENDER_ID", insertable=false, updatable=false)
	private User user_from;

	@ManyToOne
	@JoinColumn(name = "USER_RECIPIENT_ID", insertable=false, updatable=false)
	private User user_to;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUser_sender_id() {
		return user_sender_id;
	}

	public void setUser_sender_id(Integer user_sender_id) {
		this.user_sender_id = user_sender_id;
	}

	public Integer getUser_recipient_id() {
		return user_recipient_id;
	}

	public void setUser_recipient_id(Integer user_recipient_id) {
		this.user_recipient_id = user_recipient_id;
	}

	public User getUser_from() {
		return user_from;
	}

	public void setUser_from(User user_from) {
		this.user_from = user_from;
	}

	public User getUser_to() {
		return user_to;
	}

	public void setUser_to(User user_to) {
		this.user_to = user_to;
	}
	
}
