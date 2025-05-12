#!/bin/bash -x  # Enables debug mode
# AdamAI Project Manager v1.2 - Improved Python version checking

# Configuration
PROJECT_NAME="AdamAI"
MIN_PYTHON_VERSION="3.9"  # Minimum required version
VENV_DIR="venv"
GIT_REPO="https://github.com/yourusername/AdamAI.git"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to compare Python versions
version_compare() {
    local required=(${1//./ })
    local current=(${2//./ })
    
    for i in {0..2}; do
        if (( ${current[i]:-0} < ${required[i]:-0} )); then
            return 1
        elif (( ${current[i]:-0} > ${required[i]:-0} )); then
            return 0
        fi
    done
    return 0
}

# Initialize project
init_project() {
    echo -e "${YELLOW}=== Initializing $PROJECT_NAME Project ===${NC}"
    
    # Verify Python version
    PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
    if ! version_compare "$MIN_PYTHON_VERSION" "$PYTHON_VERSION"; then
        echo -e "${RED}ERROR: Python ${MIN_PYTHON_VERSION}+ is required (found ${PYTHON_VERSION})${NC}"
        echo -e "${BLUE}Solutions:${NC}"
        echo "1. Install Python ${MIN_PYTHON_VERSION}+ using your package manager"
        echo "2. Use pyenv to manage multiple Python versions"
        echo "3. Or continue with current Python version at your own risk (not recommended)"
        
        read -p "Would you like to try continuing anyway? [y/N] " choice
        if [[ ! "$choice" =~ ^[Yy] ]]; then
            exit 1
        fi
    fi

    # Create virtual environment
    if [ ! -d "$VENV_DIR" ]; then
        python3 -m venv "$VENV_DIR"
        echo -e "${GREEN}Virtual environment created${NC}"
    else
        echo -e "${YELLOW}Virtual environment already exists${NC}"
    fi

    # Activate and install requirements
    source "$VENV_DIR/bin/activate"
    pip install --upgrade pip
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
    else
        echo -e "${YELLOW}No requirements.txt found${NC}"
    fi
    
    echo -e "${GREEN}Project initialized successfully${NC}"
}
