package dev.gertmuller88.task.exception.abstracts;

import org.springframework.http.HttpStatus;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.stream.Collectors;

public abstract class AbstractExceptionBag extends AbstractException {

    private final Set<AbstractException> exceptions;

    protected AbstractExceptionBag(final HttpStatus httpStatus) {
        super(httpStatus);
        this.exceptions = new LinkedHashSet<>();
    }

    public void addException(final AbstractException exception) {
        if(!super.getHttpStatus().equals(exception.getHttpStatus())) {
            throw new IllegalArgumentException();
        }

        this.exceptions.add(exception);
    }

    @Override
    public String getMessage() {
        return this.exceptions.stream().map(Throwable::getMessage).collect(Collectors.joining(System.lineSeparator()));
    }

    public boolean isEmpty() {
        return this.exceptions.isEmpty();
    }

}
