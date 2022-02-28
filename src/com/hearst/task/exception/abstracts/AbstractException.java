package com.hearst.task.exception.abstracts;

import org.springframework.http.HttpStatus;

public abstract class AbstractException extends RuntimeException {

    private final HttpStatus httpStatus;

    protected AbstractException(final String message, final HttpStatus httpStatus) {
        super(message);
        this.httpStatus = httpStatus;
    }

    AbstractException(final HttpStatus httpStatus) {
        this(null, httpStatus);
    }

    public HttpStatus getHttpStatus() {
        return this.httpStatus;
    }

}
