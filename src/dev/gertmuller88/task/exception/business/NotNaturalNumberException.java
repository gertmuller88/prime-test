package dev.gertmuller88.task.exception.business;

import dev.gertmuller88.task.exception.abstracts.AbstractException;
import org.springframework.http.HttpStatus;
import java.math.BigInteger;

public class NotNaturalNumberException extends AbstractException {

    public NotNaturalNumberException(final BigInteger number) {
        super(String.format("The provided number '%d' is not natural.", number), HttpStatus.BAD_REQUEST);
    }

}
