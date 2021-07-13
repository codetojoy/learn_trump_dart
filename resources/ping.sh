#!/bin/bash

PORT=5151

echo ""

echo "--------------"
echo "ping"
curl -X GET "http://localhost:$PORT/ping" | jq
echo ""

echo "--------------"
echo "Ready."
