package com.hearst.task.exception.statuses;

import com.hearst.task.exception.abstracts.AbstractExceptionBag;
import org.springframework.http.HttpStatus;

public class BadRequestException extends AbstractExceptionBag {

    public BadRequestException() {
        super(HttpStatus.BAD_REQUEST);
    }

}
