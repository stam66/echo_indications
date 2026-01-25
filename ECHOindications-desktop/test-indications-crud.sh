#!/bin/bash

API_BASE_URL="https://api.echoindications.org"
USERNAME="stam"
PASSWORD="reject67"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "Indications CRUD API Test Script"
echo "=========================================="
echo "API URL: $API_BASE_URL"
echo ""

# Step 1: Login
echo -e "${YELLOW}Step 1: Logging in...${NC}"
LOGIN_RESPONSE=$(curl -s -X POST "${API_BASE_URL}/auth.lc?action=login" \
  -H "Content-Type: application/json" \
  -d "{\"username\": \"${USERNAME}\", \"password\": \"${PASSWORD}\"}")

TOKEN=$(echo "$LOGIN_RESPONSE" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
    echo -e "${RED}Login failed.${NC}"
    echo "Response: $LOGIN_RESPONSE"
    exit 1
fi
echo -e "${GREEN}Login successful.${NC}"

# Step 2: List indications
echo -e "${YELLOW}Step 2: Testing LIST...${NC}"
curl -s "${API_BASE_URL}/indications.lc?action=list" | head -c 200
echo "..."

# Step 3: Create indication
echo -e "\n${YELLOW}Step 3: Testing CREATE...${NC}"
CREATE_RESPONSE=$(curl -s -X POST "${API_BASE_URL}/indications.lc?action=create&username=${USERNAME}" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  -d '{"title": "CURL Test","keywords": "test","primary_care": 1,"urgency": "routine","contexts": [{"id": 1}]}')

echo "$CREATE_RESPONSE"

echo -e "\n${GREEN}Done!${NC}"
