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

# Check key files in 'core' directory and validate
echo "Validating key files..."

core_files=("ai_engine.py" "ai_controller.py")
missing_files=()

for file in "${core_files[@]}"; do
    if [ ! -f "core/$file" ]; then
        missing_files+=("core/$file")
    else
        # Validate basic structure
        if [[ "$file" == "ai_engine.py" ]]; then
            if ! grep -q "class AIEngine" "core/$file"; then
                echo "File 'core/$file' does not contain expected class structure."
                missing_files+=("core/$file")
            fi
        elif [[ "$file" == "ai_controller.py" ]]; then
            if ! grep -q "class AIController" "core/$file"; then
                echo "File 'core/$file' does not contain expected class structure."
                missing_files+=("core/$file")
            fi
        fi
    fi
done

# Summarize project state
echo ""
echo "Project structure and file validation summary:"
echo "------------------------------------------------"

if [ ${#missing_files[@]} -eq 0 ]; then
    echo "All files and directories are valid."
else
    echo "The following issues were found:"
    for missing_file in "${missing_files[@]}"; do
        echo "- Missing or invalid file: $missing_file"
    done
fi

# Suggest next steps based on findings
echo ""
if [ ${#missing_files[@]} -eq 0 ]; then
    echo "Project is complete and ready for the next steps."
else
    echo "You need to fix the above files and directories before proceeding."
fi
