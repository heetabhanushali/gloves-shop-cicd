package com.glovesshop.shipping;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = "com.glovesshop.shipping")
public class JpaConfig {
}
