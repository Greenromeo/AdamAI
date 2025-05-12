#!/bin/bash

# Ensure __init__.py files are added in all necessary directories
echo "Ensuring __init__.py files are present in core, llm, and other necessary directories..."

# List of directories to check for __init__.py
directories=("core" "llm" "tests")

# Create __init__.py in each directory if not already present
for dir in "${directories[@]}"; do
    if [ ! -f "$dir/__init__.py" ]; then
        echo "Creating $dir/__init__.py"
        touch "$dir/__init__.py"
    else
        echo "$dir/__init__.py already exists"
    fi
done

# Set the PYTHONPATH to the root of the project
echo "Setting PYTHONPATH to the current project directory..."
export PYTHONPATH=$(pwd)

# Confirm the PYTHONPATH
echo "Current PYTHONPATH: $PYTHONPATH"

# Run the tests again
echo "Running tests..."
pytest tests/test_ai_engine.py
