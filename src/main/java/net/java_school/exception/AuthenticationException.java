package net.java_school.exception;

public class AuthenticationException extends RuntimeException {

	private static final long serialVersionUID = -2916142666133028059L;

	public AuthenticationException() {
		super();
	}

	public AuthenticationException(String message, Throwable cause,
			boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public AuthenticationException(String message, Throwable cause) {
		super(message, cause);
	}

	public AuthenticationException(String message) {
		super(message);
	}

	public AuthenticationException(Throwable cause) {
		super(cause);
	}
		
}