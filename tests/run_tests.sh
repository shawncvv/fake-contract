#!/bin/bash
# Test runner script for README.md validation

set -euo pipefail

cd "$(dirname "$0")/.."

echo "=================================="
echo "README.md Validation Test Suite"
echo "=================================="
echo ""

# Check Python availability
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required to run tests"
    exit 1
fi

echo "Python version: $(python3 --version)"
echo ""

# Run the tests
python3 tests/test_readme.py

# Check exit code
if [ $? -eq 0 ]; then
    echo ""
    echo "=================================="
    echo "✅ All tests passed successfully!"
    echo "=================================="
    exit 0
else
    echo ""
    echo "=================================="
    echo "❌ Some tests failed"
    echo "=================================="
    exit 1
fi