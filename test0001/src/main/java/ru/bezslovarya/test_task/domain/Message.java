package ru.bezslovarya.test_task.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Min;
import org.hibernate.validator.constraints.NotBlank;

//import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;

@Entity
@Table(name = "MESSAGES")
public class Message {

	@Id
	@Column(name = "ID")
	@GeneratedValue
	private Integer id;

	@Column(name = "USER_FROM_ID")
	private Integer user_from_id;

	@Column(name = "USER_TO_ID")
	private Integer user_to_id;

	@Column(name = "DT")
	private Date dt;

	@NotNull(message = "Тема сообщения отсутствует!(null)")
    @NotBlank(message = "Тема сообщения отсутствует!")	
	@Column(name = "subj", nullable = false)
	private String subj;

	@Column(name = "msg")
	private String msg;

	@Transient
	private String userName;

	@Min(value=1, message = "Не выбран получатель!")
	@Transient
	private Integer userID;

	//@Transient
	@ManyToOne
	@JoinColumn(name = "user_from_id", insertable=false)
	private User user_from;

	//@Transient	
	@ManyToOne
	@JoinColumn(name = "user_to_id", insertable=false)
	private User user_to;
	

	public User getUser_to() {
		return user_to;
	}

	public void setUser_to(User user_to) {
		this.user_to = user_to;
	}

	public User getUser_from() {
		return user_from;
	}

	public void setUser_from(User user_from) {
		this.user_from = user_from;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	// public User getUser() {
	// return user;
	// }
	//
	// public void setUser(User user) {
	// this.user = user;
	// }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUser_from_id() {
		return user_from_id;
	}

	public void setUser_from_id(Integer user_from_id) {
		this.user_from_id = user_from_id;
	}

	public Integer getUser_to_id() {
		return user_to_id;
	}

	public void setUser_to_id(Integer user_to_id) {
		this.user_to_id = user_to_id;
	}

	public Date getDt() {
		return dt;
	}

	public void setDt(Date dt) {
		this.dt = dt;
	}

	public String getSubj() {
		return subj;
	}

	public void setSubj(String subj) {
		this.subj = subj;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
