package com.model2.mvc.common.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;

public class ProtocolUtil {

	public ProtocolUtil() {
		// TODO Auto-generated constructor stub
	}

	public static String getBody(HttpServletRequest request) throws Exception {
		String body = null;
		StringBuilder stringBuilder = new StringBuilder();
		
		BufferedReader bufferedReader = null;
		
		InputStream inputStream = request.getInputStream();
		if(inputStream != null) {
			bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
			char[] charBuffer = new char[128];
			int bytesRead = -1;
			while((bytesRead = bufferedReader.read(charBuffer)) > 0) {
				stringBuilder.append(charBuffer, 0, bytesRead);
			}
		}
		body = stringBuilder.toString();
		return body;
	}
}