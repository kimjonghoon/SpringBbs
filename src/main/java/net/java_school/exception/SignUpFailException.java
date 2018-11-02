package net.java_school.exception;

public class SignUpFailException extends RuntimeException {

    private static final long serialVersionUID = 4175726732067144500L;

    public SignUpFailException() {
        super();
    }

    public SignUpFailException(String message, Throwable cause,
            boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }

    public SignUpFailException(String message, Throwable cause) {
        super(message, cause);
    }

    public SignUpFailException(String message) {
        super(message);
    }

    public SignUpFailException(Throwable cause) {
        super(cause);
    }

}
