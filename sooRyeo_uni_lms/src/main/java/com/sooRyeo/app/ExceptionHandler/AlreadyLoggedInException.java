package com.sooRyeo.app.ExceptionHandler;

public class AlreadyLoggedInException extends RuntimeException {
    public AlreadyLoggedInException(String message) {
        super(message);
    }

}
