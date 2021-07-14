#!/bin/bash

set -e

# uses this: https://github.com/apastuhov/dart_dot_reporter

dart pub run test --reporter=json > test.log || echo 'Tests failed'
dart_dot_reporter test.log

