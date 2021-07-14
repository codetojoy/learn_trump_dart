#!/bin/bash

set -e

dart run bin/server_trump_dart.dart | tee server.out.log

