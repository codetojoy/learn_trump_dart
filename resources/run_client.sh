#!/bin/bash

PORT=5151

echo ""

echo "--------------"
echo "get rank"
curl -X GET "http://localhost:$PORT/rank?trump=C&leading=U&cards=10C,9C,8C,7C,6C,5C,4C,3C,2C"
echo ""

echo "--------------"
echo "Ready."
