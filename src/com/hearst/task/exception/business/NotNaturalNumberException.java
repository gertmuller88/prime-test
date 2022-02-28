package com.hearst.task.exception.business;

import com.hearst.task.exception.abstracts.AbstractException;
import org.springframework.http.HttpStatus;
import java.math.BigInteger;

public class NotNaturalNumberException extends AbstractException {

    public NotNaturalNumberException(final BigInteger number) {
        super(String.format("The provided number '%d' is not natural.", number), HttpStatus.BAD_REQUEST);
    }

}
