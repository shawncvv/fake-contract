# README.md Validation Tests

Comprehensive validation tests for the README.md file in the fake-contract repository.

## Overview

The test suite validates:
- **Structure**: File existence, encoding, formatting
- **Required Sections**: All necessary sections are present
- **Content Validation**: Warnings, disclaimers, and educational purpose
- **Markdown Syntax**: Proper markdown formatting
- **Consistency**: Documentation matches actual repository state
- **Safety Compliance**: Ethical standards and warnings
- **Accessibility**: Readability and visual indicators

## Running Tests

### Using the test runner script:
```bash
./tests/run_tests.sh
```

### Running tests directly with Python:
```bash
python3 tests/test_readme.py
```

### Running specific test classes:
```bash
python3 -m unittest tests.test_readme.TestReadmeStructure -v
python3 -m unittest tests.test_readme.TestReadmeSafetyCompliance -v
```

## Test Categories

### 1. TestReadmeStructure
- File existence and type
- UTF-8 encoding for Chinese characters
- Proper line endings
- Non-empty content

### 2. TestReadmeRequiredSections
- Main title
- Project introduction
- Warning section
- Directory structure
- Analysis objectives
- Target audience
- Contribution guidelines
- Legal disclaimer

### 3. TestReadmeContentValidation
- Educational purpose emphasis
- Investment warning
- Interaction warnings
- File references
- Target audience details

### 4. TestReadmeMarkdownSyntax
- Header formatting
- List formatting
- Bold text
- Code blocks
- Horizontal rules

### 5. TestReadmeConsistency
- Documented files exist
- No broken internal references

### 6. TestReadmeSafetyCompliance
- No promotion of illegal activities
- Clear educational purpose
- Prominent disclaimers
- No contract addresses
- Risk warnings

### 7. TestReadmeAccessibility
- Visual indicators (emojis)
- Section separation
- Paragraph spacing

## Test Coverage

The test suite includes **40+ individual test cases** covering all aspects of README validation.

## Requirements

- Python 3.6 or higher
- No external dependencies (uses Python standard library only)

## Exit Codes

- `0`: All tests passed
- `1`: One or more tests failed