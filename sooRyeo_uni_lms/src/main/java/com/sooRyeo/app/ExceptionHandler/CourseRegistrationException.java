package com.sooRyeo.app.ExceptionHandler;

public class CourseRegistrationException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public CourseRegistrationException(String message) {
		super(message);
	}

	public CourseRegistrationException(String message, Throwable cause) {
		super(message, cause);
	}

}
