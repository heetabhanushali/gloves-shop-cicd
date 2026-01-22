package com.glovesshop.shipping;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class Calculator {

    private static final Logger logger = LoggerFactory.getLogger(Calculator.class);

    public Ship calculate(Map<String, Object> request) {
        logger.info("Calculating shipping cost");

        String city = (String) request.get("city");
        List<?> items = (List<?>) request.get("items");

        int itemCount = items != null ? items.size() : 1;
        double baseCost = 5.0;
        double itemCost = itemCount * 1.5;
        double total = baseCost + itemCost;

        Ship ship = new Ship();
        ship.setCity(city);
        ship.setCost(total);

        logger.info("Shipping cost calculated: {}", total);
        return ship;
    }
}
