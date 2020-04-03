package com.spring.biz.common;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.spring.biz.user.UserVO;


public class MailUtil {
	private String host = "smtp.naver.com";  // 메일전송서버주소
	private String adminUser = "alapo@naver.com"; // 관리자 계정
	private String adminPassword = "azak87531a!"; // 관리자 PW
	
	Properties props = new Properties();
	
	
	public void mailSendNaver(UserVO vo) throws Exception {

//		SMTP 서버 설정.
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(adminUser, adminPassword);
			}
		});
		
		try {
			MimeMessage message = new MimeMessage(session);
//			송신 이메일 주소
			InternetAddress from = new InternetAddress(adminUser,"Tourist");
			
			message.setFrom(from);
//			수신 이메일 주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(adminUser));

			// 송신 제목
			message.setSubject("[Tourist] "+ vo.getId() + "님이 매니저 권한을 요청했습니다.");

			// 메일 내용
			String cont = "ID : " + vo.getId() +"<br>"
						 +"이름 : " + vo.getName() +"<br>"
						 +"Mail : " + vo.getMail() +"<br>"
						 +"가입일 : " + vo.getRegDate() +"<br>"
						 +"<a href='http://localhost:8480/biz/index.do'>홈페이지</a>";
			// 메일 내용형식 설정
			message.setContent(cont, "text/html; charset=UTF-8");
			
			// 전송처리
			Transport.send(message);
		} catch (MessagingException e) {System.out.println("mailSendNaver() 메일 전송 실패");}
	}
	
	public String mailCodeSendNaver(String userMail) throws Exception {

//		SMTP 서버 설정.
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(adminUser, adminPassword);
			}
		});
		
//		인증 코드 생성
		String confirmCode = setCode();
		
		try {
			MimeMessage message = new MimeMessage(session);
//			송신 정보(메일 주소 및 이름) 설정	
			InternetAddress from = new InternetAddress(adminUser,"Tourist");
			
//			송신 이메일 주소
			message.setFrom(from);
//			수신 이메일 주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(userMail));

//			송신 제목
			message.setSubject("[Tourist] 이메일 인증 코드 입니다.");

			
//			메일 내용
			String cont = "귀하의 이메일 인증 코드는 [<font style=\"color: blue;\">"+confirmCode+"</font>] 입니다.</p><br><br>"
						 +"만약, 본인이 아니신 경우 이 메일을 무시하셔도 됩니다.<br><br>"
						 +"감사합니다.";
//			메일 내용형식 설정		
			message.setContent(cont, "text/html; charset=UTF-8");
			
//			전송처리
			Transport.send(message);
		} catch (MessagingException e) {System.out.println("mailCodeSendNaver() 메일 전송 실패");}
		
		return confirmCode;
	}
	public void sendTempPwNaver(String tempPw, String mail) throws Exception {
//		SMTP 서버 설정.
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(adminUser, adminPassword);
			}
		});
		
		try {
			MimeMessage message = new MimeMessage(session);
//			송신 정보(메일 주소 및 이름) 설정	
			InternetAddress from = new InternetAddress(adminUser,"Tourist");
			
//			송신 이메일 주소
			message.setFrom(from);
//			수신 이메일 주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mail));

//			송신 제목
			message.setSubject("[Tourist] 회원님의 임시 패스워드가 발급되었습니다.");

			
//			메일 내용
			String cont = "임시 패스워드는 [<font style=\"color: blue;\">"+tempPw+"</font>] 입니다.</p><br><br>"
						 +"해당 패스워드를 사용하여 로그인 후 패스워드를 변경하시길 권장합니다.<br><br>"
						 +"감사합니다.";
//			메일 내용형식 설정		
			message.setContent(cont, "text/html; charset=UTF-8");
			
//			전송처리
			Transport.send(message);
		} catch (MessagingException e) {System.out.println("sendTempPwNaver() 메일 전송 실패");	}
	}
	
//	인증 코드 생성 난수
	public String setCode() {
		StringBuffer sb = new StringBuffer();
		int a = 0;
		for (int i = 0; i < 6; i++) {
			a = (int) (Math.random() * 122 + 1);
			if ((a >= 48 && a <= 57) || (a >= 65 && a <= 90) || (a >= 97 && a <= 122)) {
				sb.append((char) a);
			}else { i--; }
		}
		return sb.toString();
	}
}