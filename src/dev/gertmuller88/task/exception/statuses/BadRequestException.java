package dev.gertmuller88.task.exception.statuses;

import dev.gertmuller88.task.exception.abstracts.AbstractExceptionBag;
import org.springframework.http.HttpStatus;

public class BadRequestException extends AbstractExceptionBag {

    public BadRequestException() {
        super(HttpStatus.BAD_REQUEST);
    }

}
