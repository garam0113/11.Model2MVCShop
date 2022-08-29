package com.model2.mvc.service.domain;

public class Basket {
	
	private String userId;
	private int prodNo;
	private int basketCount;

	public Basket() {
		// TODO Auto-generated constructor stub
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getProdNo() {
		return prodNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public int getBasketCount() {
		return basketCount;
	}

	public void setBasketCount(int basketCount) {
		this.basketCount = basketCount;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "Basket : [userId] = " + userId + " [prodNo] = " + prodNo + " [basketCount] = "+ basketCount;

	}

}
