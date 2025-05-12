#!/bin/bash

# Ensure the basic structure exists
echo "Checking project structure..."

# Define required directories
dirs=("core" "llm" "models" "tests" "config" "utils")

# Create any missing directories
for dir in "${dirs[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "Directory '$dir' missing. Creating it."
        mkdir "$dir"
    fi
done

# Ensure __init__.py exists in required directories
for dir in "${dirs[@]}"; do
    if [ ! -f "$dir/__init__.py" ]; then
        echo "File '$dir/__init__.py' missing. Creating it."
        touch "$dir/__init__.py"
    fi
done

# Check all Python files in the project for basic content validation
echo "Validating Python files in the project..."

# Recursively find all Python files in the project
python_files=$(find . -name "*.py")

missing_files=()
invalid_files=()

for file in $python_files; do
    if [ ! -s "$file" ]; then
        missing_files+=("$file")
        continue
    fi

    # Check for basic class structure or functions in each file
    if ! grep -q "class " "$file" && ! grep -q "def " "$file"; then
        invalid_files+=("$file")
    fi

    # Example: Specific checks for important files like ai_engine.py
    if [[ "$file" == *"core/ai_engine.py"* ]]; then
        if ! grep -q "class AIEngine" "$file"; then
            invalid_files+=("$file")
        fi
    elif [[ "$file" == *"core/ai_controller.py"* ]]; then
        if ! grep -q "class AIController" "$file"; then
            invalid_files+=("$file")
        fi
    fi
done

# Summarize project state
echo ""
echo "Project structure and file validation summary:"
echo "------------------------------------------------"

if [ ${#missing_files[@]} -eq 0 ] && [ ${#invalid_files[@]} -eq 0 ]; then
    echo "All files and directories are valid."
else
    if [ ${#missing_files[@]} -gt 0 ]; then
        echo "The following files are missing or empty:"
        for missing_file in "${missing_files[@]}"; do
            echo "- $missing_file"
        done
    fi

    if [ ${#invalid_files[@]} -gt 0 ]; then
        echo "The following files do not contain expected class or function definitions:"
        for invalid_file in "${invalid_files[@]}"; do
            echo "- $invalid_file"
        done
    fi
fi

# Suggest next steps based on findings
echo ""
if [ ${#missing_files[@]} -eq 0 ] && [ ${#invalid_files[@]} -eq 0 ]; then
    echo "Project is complete and ready for the next steps."
else
    echo "You need to fix the above files and directories before proceeding."
fi
