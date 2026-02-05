-- ===========================================
-- GLOVES SHOP SEED DATA
-- ===========================================

USE gloves_shop;

-- ===========================================
-- COUNTRY CODES
-- ===========================================

INSERT INTO codes (code) VALUES 
('US'),
('UK'),
('DE'),
('FR'),
('IN'),
('AU'),
('CA'),
('JP'),
('BR'),
('AE');

-- ===========================================
-- CITIES DATA
-- ===========================================

INSERT INTO cities (country_code, city_code, name, region, latitude, longitude, code_id) VALUES
-- United States
('US', 'NYC', 'New York', 'New York', 40.7128, -74.0060, 1),
('US', 'LAX', 'Los Angeles', 'California', 34.0522, -118.2437, 1),
('US', 'CHI', 'Chicago', 'Illinois', 41.8781, -87.6298, 1),
('US', 'HOU', 'Houston', 'Texas', 29.7604, -95.3698, 1),
('US', 'PHX', 'Phoenix', 'Arizona', 33.4484, -112.0740, 1),
('US', 'SFO', 'San Francisco', 'California', 37.7749, -122.4194, 1),
('US', 'SEA', 'Seattle', 'Washington', 47.6062, -122.3321, 1),
('US', 'MIA', 'Miami', 'Florida', 25.7617, -80.1918, 1),

-- United Kingdom
('UK', 'LON', 'London', 'England', 51.5074, -0.1278, 2),
('UK', 'MAN', 'Manchester', 'England', 53.4808, -2.2426, 2),
('UK', 'BIR', 'Birmingham', 'England', 52.4862, -1.8904, 2),
('UK', 'GLA', 'Glasgow', 'Scotland', 55.8642, -4.2518, 2),
('UK', 'LIV', 'Liverpool', 'England', 53.4084, -2.9916, 2),

-- Germany
('DE', 'BER', 'Berlin', 'Berlin', 52.5200, 13.4050, 3),
('DE', 'MUN', 'Munich', 'Bavaria', 48.1351, 11.5820, 3),
('DE', 'FRA', 'Frankfurt', 'Hesse', 50.1109, 8.6821, 3),
('DE', 'HAM', 'Hamburg', 'Hamburg', 53.5511, 9.9937, 3),
('DE', 'COL', 'Cologne', 'North Rhine-Westphalia', 50.9375, 6.9603, 3),
('DE', 'AAC', 'Aachen', 'North Rhine-Westphalia', 50.7753, 6.0839, 3),

-- France
('FR', 'PAR', 'Paris', 'Île-de-France', 48.8566, 2.3522, 4),
('FR', 'LYO', 'Lyon', 'Auvergne-Rhône-Alpes', 45.7640, 4.8357, 4),
('FR', 'MAR', 'Marseille', 'Provence', 43.2965, 5.3698, 4),
('FR', 'NIC', 'Nice', 'Provence', 43.7102, 7.2620, 4),

-- India
('IN', 'MUM', 'Mumbai', 'Maharashtra', 19.0760, 72.8777, 5),
('IN', 'DEL', 'Delhi', 'Delhi', 28.6139, 77.2090, 5),
('IN', 'BLR', 'Bangalore', 'Karnataka', 12.9716, 77.5946, 5),
('IN', 'HYD', 'Hyderabad', 'Telangana', 17.3850, 78.4867, 5),
('IN', 'CHN', 'Chennai', 'Tamil Nadu', 13.0827, 80.2707, 5),
('IN', 'PUN', 'Pune', 'Maharashtra', 18.5204, 73.8567, 5),

-- Australia
('AU', 'SYD', 'Sydney', 'New South Wales', -33.8688, 151.2093, 6),
('AU', 'MEL', 'Melbourne', 'Victoria', -37.8136, 144.9631, 6),
('AU', 'BRI', 'Brisbane', 'Queensland', -27.4698, 153.0251, 6),
('AU', 'PER', 'Perth', 'Western Australia', -31.9505, 115.8605, 6),

-- Canada
('CA', 'TOR', 'Toronto', 'Ontario', 43.6532, -79.3832, 7),
('CA', 'VAN', 'Vancouver', 'British Columbia', 49.2827, -123.1207, 7),
('CA', 'MTL', 'Montreal', 'Quebec', 45.5017, -73.5673, 7),
('CA', 'CAL', 'Calgary', 'Alberta', 51.0447, -114.0719, 7),

-- Japan
('JP', 'TYO', 'Tokyo', 'Kanto', 35.6762, 139.6503, 8),
('JP', 'OSA', 'Osaka', 'Kansai', 34.6937, 135.5023, 8),
('JP', 'KYO', 'Kyoto', 'Kansai', 35.0116, 135.7681, 8),

-- Brazil
('BR', 'SAO', 'São Paulo', 'São Paulo', -23.5505, -46.6333, 9),
('BR', 'RIO', 'Rio de Janeiro', 'Rio de Janeiro', -22.9068, -43.1729, 9),

-- UAE
('AE', 'DXB', 'Dubai', 'Dubai', 25.2048, 55.2708, 10),
('AE', 'AUH', 'Abu Dhabi', 'Abu Dhabi', 24.4539, 54.3773, 10);

-- ===========================================
-- SAMPLE RATINGS FOR GLOVES
-- ===========================================

INSERT INTO ratings (sku, avg_rating, rating_count) VALUES
('GLOVE-001', 4.50, 128),
('GLOVE-002', 4.75, 89),
('GLOVE-003', 4.25, 256),
('GLOVE-004', 4.80, 73),
('GLOVE-005', 4.60, 94),
('GLOVE-006', 4.35, 167),
('GLOVE-007', 4.55, 52),
('GLOVE-008', 4.70, 83);