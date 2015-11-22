package ru.bezslovarya.test_task.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
//import javax.persistence.GeneratedValue;
import javax.persistence.Id;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
//import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotBlank;

@Entity
@Table(name = "USERS")
public class User {
	
	@Id
	@Column(name = "ID")
	@GeneratedValue
	private Integer id;

	@NotNull(message = "Не указано имя!(null)")
    @NotBlank(message = "Не указано имя!")	
	@Column(name = "FIO")
	private String FIO;

	@NotNull(message = "Не указан email!(null)")
    @NotBlank(message = "Не указан email!")	
	@Column(name = "email")
	private String email;

	@NotNull(message = "Не указан логин!(null)")
    @NotBlank(message = "Не указан логин!")	
	@Column(name = "username")
	private String username;

	@NotNull(message = "Не указан пароль!(null)")
    @NotBlank(message = "Не указан пароль!")	
	@Column(name = "password")
	private String password;
	
	@Column(name = "enabled")
	private Boolean enabled;
	
	@Transient
	private Boolean isAdmin;

	@Transient
	private String adminGroup;
	
	public String getAdminGroup() {
		return adminGroup;
	}

	public void setAdminGroup(String adminGroup) {
		this.adminGroup = adminGroup;
	}

	public Boolean getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFIO() {
		return FIO;
	}

	public void setFIO(String fIO) {
		FIO = fIO;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}
