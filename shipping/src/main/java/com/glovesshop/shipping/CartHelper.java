package com.glovesshop.shipping;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Component
public class CartHelper {

    private static final Logger logger = LoggerFactory.getLogger(CartHelper.class);

    @Value("${cart.endpoint:cart:8080}")
    private String cartEndpoint;

    private RestTemplate restTemplate = new RestTemplate();

    public Map<String, Object> getCart(String userId) {
        logger.info("Getting cart for user: {}", userId);
        String url = "http://" + cartEndpoint + "/cart/" + userId;
        try {
            ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
            return response.getBody();
        } catch (Exception e) {
            logger.error("Error getting cart", e);
            return null;
        }
    }
}
