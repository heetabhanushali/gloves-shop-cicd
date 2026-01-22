package com.glovesshop.shipping;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
public class Controller {

    private static final Logger logger = LoggerFactory.getLogger(Controller.class);

    @Autowired
    private CityRepository cityRepository;

    @Autowired
    private CodeRepository codeRepository;

    @Autowired
    private Calculator calculator;

    @GetMapping("/health")
    public String health() {
        return "OK";
    }

    @GetMapping("/cities/{code}")
    public ResponseEntity<?> getCities(@PathVariable String code) {
        logger.info("Getting cities for code: {}", code);
        Code c = codeRepository.findByCode(code);
        if (c == null) {
            return new ResponseEntity<>("Code not found", HttpStatus.NOT_FOUND);
        }
        List<City> cities = cityRepository.findByCode(c);
        return new ResponseEntity<>(cities, HttpStatus.OK);
    }

    @GetMapping("/codes")
    public ResponseEntity<?> getCodes() {
        logger.info("Getting all codes");
        List<Code> codes = codeRepository.findAll();
        return new ResponseEntity<>(codes, HttpStatus.OK);
    }

    @PostMapping("/shipping")
    public ResponseEntity<?> calculateShipping(@RequestBody Map<String, Object> request) {
        logger.info("Calculating shipping: {}", request);
        try {
            Ship ship = calculator.calculate(request);
            return new ResponseEntity<>(ship, HttpStatus.OK);
        } catch (Exception e) {
            logger.error("Error calculating shipping", e);
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
