-- ===========================================
-- GLOVES SHOP DATABASE SCHEMA
-- ===========================================
USE gloves_shop;

-- ===========================================
-- SHIPPING TABLES
-- ===========================================

-- Country/Region codes
CREATE TABLE IF NOT EXISTS codes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Cities for shipping calculation
CREATE TABLE IF NOT EXISTS cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country_code VARCHAR(3) NOT NULL,
    city_code VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    latitude DECIMAL(10, 6),
    longitude DECIMAL(10, 6),
    code_id INT,
    FOREIGN KEY (code_id) REFERENCES codes(id)
) ENGINE=InnoDB;

-- ===========================================
-- RATINGS TABLE
-- ===========================================

CREATE TABLE IF NOT EXISTS ratings (
    sku VARCHAR(80) NOT NULL PRIMARY KEY,
    avg_rating DECIMAL(3, 2) NOT NULL DEFAULT 0.00,
    rating_count INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- ===========================================
-- INDEXES
-- ===========================================

CREATE INDEX idx_cities_country ON cities(country_code);
CREATE INDEX idx_cities_code_id ON cities(code_id);