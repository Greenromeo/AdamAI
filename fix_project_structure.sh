#!/bin/bash

# Enhanced project structure fixer with better error handling

set -e  # Exit on error

echo "=== Starting project structure fix ==="
echo "Current working directory: $(pwd)"
echo

# ====== 1. Create directories and __init__.py files ======
declare -a dirs=("models" "utils" "llm" "config" "core" "tests")

for dir in "${dirs[@]}"; do
    echo "Processing directory: $dir"
    
    # Create directory if missing
    if [ ! -d "$dir" ]; then
        echo "  -> Creating directory..."
        mkdir -pv "$dir"
    fi
    
    # Create __init__.py if missing
    init_file="$dir/__init__.py"
    if [ ! -f "$init_file" ]; then
        echo "  -> Creating $init_file"
        echo "# Package initialization" > "$init_file"
        echo "__all__ = []" >> "$init_file"
    else
        echo "  -> $init_file already exists"
    fi
    
    # Verify creation
    if [ ! -f "$init_file" ]; then
        echo "  !! ERROR: Failed to create $init_file"
        exit 1
    fi
done

echo
# ====== 2. Handle settings.py ======
settings_file="config/settings.py"
echo "Processing $settings_file"

if [ ! -s "$settings_file" ]; then
    echo "  -> Creating default settings.py"
    cat << 'EOF' > "$settings_file"
# Configuration settings for the project

class Settings:
    """Main configuration class"""
    
    def __init__(self):
        self.model_name = "default_model"
        self.api_key = None
        self.debug = False

    def validate(self):
        """Validate configuration"""
        if not self.model_name:
            raise ValueError("Model name must be set")

# Default settings instance
settings = Settings()
EOF
else
    echo "  -> $settings_file already exists with content"
fi

echo
# ====== 3. Handle test_engine.py ======
test_file="tests/test_engine.py"
echo "Processing $test_file"

if [ ! -f "$test_file" ]; then
    echo "  -> Creating basic test file"
    cat << 'EOF' > "$test_file"
import pytest
from core.engine import Engine

class TestEngine:
    def test_initialization(self):
        engine = Engine()
        assert engine is not None

    def test_sample_method(self):
        engine = Engine()
        result = engine.sample_method()
        assert result == expected_value
EOF
else
    echo "  -> $test_file already exists"
fi

echo
# ====== 4. Verify fixes ======
echo "=== Verification ==="
echo "Checking created files:"

for dir in "${dirs[@]}"; do
    init_file="$dir/__init__.py"
    if [ -f "$init_file" ]; then
        echo "  ✓ $init_file exists"
    else
        echo "  ✗ $init_file missing"
    fi
done

[ -s "$settings_file" ] && echo "  ✓ $settings_file exists with content" || echo "  ✗ $settings_file missing/empty"
[ -f "$test_file" ] && echo "  ✓ $test_file exists" || echo "  ✗ $test_file missing"

echo
echo "=== Project structure fix completed ==="
