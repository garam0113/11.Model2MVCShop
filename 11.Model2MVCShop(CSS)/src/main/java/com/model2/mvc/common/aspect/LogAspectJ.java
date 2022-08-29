package com.model2.mvc.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

public class LogAspectJ {

	public LogAspectJ() {
		// TODO Auto-generated constructor stub
		System.out.println("\nCommon :: " + this.getClass() + "\n");
	}

	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable{
		
		System.out.println("[Around before] Ÿ�� ��ü.�޼ҵ� : "
				+ joinPoint.getTarget().getClass().getName() + "." 
				+ joinPoint.getSignature().getName());
		
		if(joinPoint.getArgs().length != 0) {
			for(int i = 0 ; i < joinPoint.getArgs().length ; i++) {
				System.out.println("[Around before] �޼ҵ忡 ���޵Ǵ� ���� : " + joinPoint.getArgs()[i]);
			}
		}
		
		Object obj = joinPoint.proceed();
		
		System.out.println("[Around after] Ÿ�� ��ü return value : " + obj);
		System.out.println("");
		
		return obj;
	}
}
