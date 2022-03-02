package dev.gertmuller88.task.service;

import dev.gertmuller88.task.exception.abstracts.AbstractExceptionBag;
import dev.gertmuller88.task.exception.business.NotNaturalNumberException;
import dev.gertmuller88.task.exception.statuses.BadRequestException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigInteger;

@Service
public class PrimalityTestService {

    @Transactional(readOnly = true)
    public Boolean testPrimality(final BigInteger number) {
        this.validateNumber(number);

        if(number.compareTo(BigInteger.ONE)<=0) {
            return Boolean.FALSE;
        }

        for(BigInteger divider = BigInteger.TWO; divider.compareTo(number)<0; divider = divider.add(BigInteger.ONE)) {
            if(number.mod(divider).equals(BigInteger.ZERO)) {
                return Boolean.FALSE;
            }
        }

        return Boolean.TRUE;
    }

    @Transactional(readOnly = true)
    public Boolean testPrimalityFaster(final BigInteger number) {
        this.validateNumber(number);

        if(number.compareTo(BigInteger.ONE)<=0) {
            return Boolean.FALSE;
        }

        for(BigInteger divider = BigInteger.TWO; divider.pow(2).compareTo(number)<=0; divider = divider.add(BigInteger.ONE)) {
            if(number.mod(divider).equals(BigInteger.ZERO)) {
                return Boolean.FALSE;
            }
        }

        return Boolean.TRUE;
    }

    private void validateNumber(final BigInteger number) {
        final AbstractExceptionBag exceptions = new BadRequestException();

        if(number.compareTo(BigInteger.ZERO)<0) {
            exceptions.addException(new NotNaturalNumberException(number));
        }

        if(!exceptions.isEmpty()) {
            throw exceptions;
        }
    }

}
