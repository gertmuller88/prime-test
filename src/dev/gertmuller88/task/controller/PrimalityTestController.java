package dev.gertmuller88.task.controller;

import dev.gertmuller88.task.service.PrimalityTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import java.math.BigInteger;

@RestController
@Validated
@RequestMapping({ "/prime" })
public class PrimalityTestController {

    private final PrimalityTestService primalityTestService;

    @Autowired
    public PrimalityTestController(final PrimalityTestService primalityTestService) {
        this.primalityTestService = primalityTestService;
    }

    @PostMapping({ "/test", "/test/" })
    @ResponseStatus(HttpStatus.OK)
    @Cacheable(value="number", key="#number")
    public @ResponseBody Boolean post(@RequestBody final BigInteger number) {
        return this.primalityTestService.testPrimalityFaster(number);
    }

}
