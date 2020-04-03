package com.spring.biz.user;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class UserVO {
	private String id;
	private String password;
	private String name;
	private String mail;
	private String mailConfirm;
	private String role;
	private Date regDate;
	private String mangerRequest;
	private Date requestDate;
}
