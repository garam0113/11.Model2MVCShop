package com.model2.mvc.service.domain;

public class Reply {

	private int replyNo;
	private String userId;
	private String reply;
	private String date;
	private String flag;
	
	public Reply() {
		// TODO Auto-generated constructor stub
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "[Reply] >> replyNo : " + replyNo + " userId : " + userId + " reply : " + reply + " date : " + date + " flag = " + flag;
	}
}
