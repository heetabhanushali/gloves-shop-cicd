#!/bin/bash

# ===========================================
# GLOVES SHOP - COMPLETE TEST SUITE
# ===========================================

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASS=0
FAIL=0

check() {
    local description=$1
    local result=$2
    local expected=$3

    if echo "$result" | grep -q "$expected"; then
        echo -e "${GREEN}✅ PASS${NC} - $description"
        PASS=$((PASS + 1))
    else
        echo -e "${RED}❌ FAIL${NC} - $description"
        echo "   Expected: $expected"
        echo "   Got: $result"
        FAIL=$((FAIL + 1))
    fi
}

echo "========================================="
echo "  GLOVES SHOP - SYSTEM TEST"
echo "========================================="
echo ""

# ===========================================
# CONTAINER HEALTH
# ===========================================
echo "${YELLOW}--- Container Health ---${NC}"
echo ""

CONTAINERS="web catalogue user cart payment shipping ratings dispatch mongodb mysql redis rabbitmq"
for CONTAINER in $CONTAINERS; do
    STATUS=$(docker inspect -f '{{.State.Running}}' gloves-shop-$CONTAINER 2>/dev/null)
    check "Container: $CONTAINER" "$STATUS" "true"
done

echo ""

# ===========================================
# SERVICE HEALTH ENDPOINTS
# ===========================================
echo "${YELLOW}--- Service Health Checks ---${NC}"
echo ""

# Catalogue Health
RESULT=$(curl -s http://localhost:8080/api/catalogue/health)
check "Catalogue health" "$RESULT" "OK"

# User Health
RESULT=$(curl -s http://localhost:8080/api/user/health)
check "User health" "$RESULT" "OK"

# Cart Health
RESULT=$(curl -s http://localhost:8080/api/cart/health)
check "Cart health" "$RESULT" "OK"

# Payment Health
RESULT=$(curl -s http://localhost:8080/api/payment/health)
check "Payment health" "$RESULT" "OK"

# Shipping Health
RESULT=$(curl -s http://localhost:8080/api/shipping/health)
check "Shipping health" "$RESULT" "OK"

# Ratings Health
RESULT=$(curl -s http://localhost:8080/api/ratings/_health)
check "Ratings health" "$RESULT" "pdo_connectivity"

echo ""

# ===========================================
# CATALOGUE SERVICE TESTS
# ===========================================
echo "${YELLOW}--- Catalogue Service ---${NC}"
echo ""

# Get all products
RESULT=$(curl -s http://localhost:8080/api/catalogue/products)
check "Get all products" "$RESULT" "GLOVE-001"

# Get single product
RESULT=$(curl -s http://localhost:8080/api/catalogue/product/GLOVE-001)
check "Get product GLOVE-001" "$RESULT" "Winter Thermal Gloves"

# Get product not found
RESULT=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/api/catalogue/product/INVALID-SKU)
check "Product not found returns 404" "$RESULT" "404"

# Get categories
RESULT=$(curl -s http://localhost:8080/api/catalogue/categories)
check "Get categories" "$RESULT" "Winter"

# Search products
RESULT=$(curl -s http://localhost:8080/api/catalogue/search/winter)
check "Search for 'winter'" "$RESULT" "Winter"

echo ""

# ===========================================
# USER SERVICE TESTS
# ===========================================
echo "${YELLOW}--- User Service ---${NC}"
echo ""

# Register new user
RESULT=$(curl -s -X POST http://localhost:8080/api/user/register \
    -H "Content-Type: application/json" \
    -d '{"name":"testuser_'$RANDOM'","password":"test123","email":"test@glovesshop.com"}')
check "Register new user" "$RESULT" "OK"

# Register duplicate user (use a fixed name, register twice)
DUPE_USER="dupetest_$RANDOM"
curl -s -X POST http://localhost:8080/api/user/register \
    -H "Content-Type: application/json" \
    -d "{\"name\":\"$DUPE_USER\",\"password\":\"test\",\"email\":\"dupe@test.com\"}" > /dev/null
RESULT=$(curl -s -X POST http://localhost:8080/api/user/register \
    -H "Content-Type: application/json" \
    -d "{\"name\":\"$DUPE_USER\",\"password\":\"test\",\"email\":\"dupe@test.com\"}")
check "Reject duplicate user" "$RESULT" "already exists"

# Register missing fields
RESULT=$(curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:8080/api/user/register \
    -H "Content-Type: application/json" \
    -d '{"name":"incomplete"}')
check "Reject incomplete registration" "$RESULT" "400"

# Login with fresh user
LOGIN_USER="logintest_$RANDOM"
curl -s -X POST http://localhost:8080/api/user/register \
    -H "Content-Type: application/json" \
    -d "{\"name\":\"$LOGIN_USER\",\"password\":\"mypass123\",\"email\":\"$LOGIN_USER@test.com\"}" > /dev/null
RESULT=$(curl -s -X POST http://localhost:8080/api/user/login \
    -H "Content-Type: application/json" \
    -d "{\"name\":\"$LOGIN_USER\",\"password\":\"mypass123\"}")
check "Login with valid credentials" "$RESULT" "$LOGIN_USER"

# Login with wrong password
RESULT=$(curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:8080/api/user/login \
    -H "Content-Type: application/json" \
    -d "{\"name\":\"$LOGIN_USER\",\"password\":\"wrongpassword\"}")
check "Reject wrong password" "$RESULT" "404"

# Check user exists
RESULT=$(curl -s http://localhost:8080/api/user/check/$LOGIN_USER)
check "Check user exists" "$RESULT" "OK"

# Check user not found
RESULT=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/api/user/check/nonexistent_user_xyz)
check "Check non-existent user" "$RESULT" "404"

# Get unique ID
RESULT=$(curl -s http://localhost:8080/api/user/uniqueid)
check "Get unique ID" "$RESULT" "anonymous"

echo ""

# ===========================================
# CART SERVICE TESTS
# ===========================================
echo "${YELLOW}--- Cart Service ---${NC}"
echo ""

# Add item to cart
RESULT=$(curl -s http://localhost:8080/api/cart/add/testcart/GLOVE-001/2)
check "Add item to cart" "$RESULT" "total"

# Get cart
RESULT=$(curl -s http://localhost:8080/api/cart/cart/testcart)
check "Get cart" "$RESULT" "GLOVE-001"

# Add another item
RESULT=$(curl -s http://localhost:8080/api/cart/add/testcart/GLOVE-003/1)
check "Add second item" "$RESULT" "GLOVE-003"

# Update quantity
RESULT=$(curl -s http://localhost:8080/api/cart/update/testcart/GLOVE-001/5)
check "Update quantity" "$RESULT" "total"

# Invalid quantity
RESULT=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/api/cart/add/testcart/GLOVE-001/abc)
check "Reject invalid quantity" "$RESULT" "400"

# Add shipping
RESULT=$(curl -s -X POST http://localhost:8080/api/cart/shipping/testcart \
    -H "Content-Type: application/json" \
    -d '{"distance":100,"cost":8.0,"location":"Berlin"}')
check "Add shipping to cart" "$RESULT" "SHIP"

# Delete cart
RESULT=$(curl -s -X DELETE http://localhost:8080/api/cart/cart/testcart)
check "Delete cart" "$RESULT" "OK"

# Get deleted cart
RESULT=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/api/cart/cart/testcart)
check "Get deleted cart returns 404" "$RESULT" "404"

echo ""

# ===========================================
# SHIPPING SERVICE TESTS
# ===========================================
echo "${YELLOW}--- Shipping Service ---${NC}"
echo ""

# Get shipping codes
RESULT=$(curl -s http://localhost:8080/api/shipping/codes)
check "Get shipping codes" "$RESULT" "code"

# Calculate shipping
RESULT=$(curl -s -X POST http://localhost:8080/api/shipping/shipping \
    -H "Content-Type: application/json" \
    -d '{"city":"Berlin","items":[{"sku":"GLOVE-001"}]}')
check "Calculate shipping" "$RESULT" "cost"

echo ""

# ===========================================
# RATINGS SERVICE TESTS
# ===========================================
echo "${YELLOW}--- Ratings Service ---${NC}"
echo ""

# Rate a product
RESULT=$(curl -s -X PUT http://localhost:8080/api/ratings/api/rate/GLOVE-001/5)
check "Rate product GLOVE-001" "$RESULT" "success"

# Fetch rating
RESULT=$(curl -s http://localhost:8080/api/ratings/api/fetch/GLOVE-001)
check "Fetch rating for GLOVE-001" "$RESULT" "avg_rating"

echo ""

# ===========================================
# INTER-SERVICE COMMUNICATION
# ===========================================
echo "${YELLOW}--- Inter-Service Communication ---${NC}"
echo ""

# Cart → Catalogue (cart fetches product details)
RESULT=$(curl -s http://localhost:8080/api/cart/add/comtest/GLOVE-002/1)
check "Cart → Catalogue communication" "$RESULT" "Leather Driving Gloves"

# Payment flow (needs shipping in cart)
curl -s http://localhost:8080/api/cart/add/paytest/GLOVE-001/1 > /dev/null
curl -s -X POST http://localhost:8080/api/cart/shipping/paytest \
    -H "Content-Type: application/json" \
    -d '{"distance":100,"cost":8.0,"location":"Berlin"}' > /dev/null

CART=$(curl -s http://localhost:8080/api/cart/cart/paytest)
RESULT=$(curl -s -X POST http://localhost:8080/api/payment/pay/paytest \
    -H "Content-Type: application/json" \
    -d "$CART")
check "Payment → Cart → User → RabbitMQ" "$RESULT" "orderid"

# Check dispatch received the order
sleep 2
RESULT=$(docker logs gloves-shop-dispatch --tail 5 2>&1)
check "Dispatch connected to RabbitMQ" "$RESULT" "Connected"

echo ""

# ===========================================
# MONITORING STACK
# ===========================================
echo "${YELLOW}--- Monitoring Stack ---${NC}"
echo ""

# Prometheus
RESULT=$(curl -s -o /dev/null -w "%{http_code}" -L http://localhost:9090)
check "Prometheus is running" "$RESULT" "200"

# Grafana
RESULT=$(curl -s -o /dev/null -w "%{http_code}" -L http://localhost:3000)
check "Grafana is running" "$RESULT" "200"

# cAdvisor
RESULT=$(curl -s -o /dev/null -w "%{http_code}" -L http://localhost:8081)
check "cAdvisor is running" "$RESULT" "200"

# RabbitMQ Management
RESULT=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:15672)
check "RabbitMQ Management is running" "$RESULT" "200"

# Cart Prometheus metrics
RESULT=$(curl -s http://localhost:8080/api/cart/metrics)
check "Cart Prometheus metrics endpoint" "$RESULT" "items_added"

echo ""

# ===========================================
# RESULTS
# ===========================================
echo "========================================="
echo "  TEST RESULTS"
echo "========================================="
echo ""
echo -e "  ${GREEN}Passed: $PASS${NC}"
echo -e "  ${RED}Failed: $FAIL${NC}"
echo "  Total:  $((PASS + FAIL))"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "  ${GREEN}🎉 ALL TESTS PASSED!${NC}"
else
    echo -e "  ${RED}⚠️  SOME TESTS FAILED${NC}"
fi

echo ""
echo "========================================="

# Cleanup
curl -s -X DELETE http://localhost:8080/api/cart/cart/comtest > /dev/null 2>&1
curl -s -X DELETE http://localhost:8080/api/cart/cart/paytest > /dev/null 2>&1