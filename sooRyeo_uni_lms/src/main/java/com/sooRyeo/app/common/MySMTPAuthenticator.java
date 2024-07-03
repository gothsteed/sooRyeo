package com.sooRyeo.app.common;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator {

	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		
		return new PasswordAuthentication("redtree041901","hrbhrhiylfapnwks");
		
	}

}