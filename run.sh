#!/bin/bash

# Catppuccin Mocha Portfolio Website - Smart Runner
# This script automatically detects available tools and runs the website with the best option

echo "🎨 Catppuccin Mocha Portfolio Website Runner"
echo "=============================================="

# Check if index.html exists
if [ ! -f "index.html" ]; then
    echo "❌ index.html not found in current directory"
    echo "   Please run this script from the website directory"
    exit 1
fi

echo "📁 Found website files in: $(pwd)"
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to run Docker
run_docker() {
    echo "🐳 Docker detected! Starting with Docker..."
    echo ""
    ./run-docker.sh
}

# Function to run Python server
run_python() {
    echo "🐍 Python detected! Starting with Python HTTP server..."
    echo ""
    ./run-python.sh
}

# Function to run Node.js server
run_node() {
    echo "🟢 Node.js detected! Starting with Node.js HTTP server..."
    echo ""
    ./run-node.sh
}

# Check available options and prioritize
if command_exists docker; then
    echo "✅ Docker is available"
    echo ""
    read -p "🐳 Would you like to use Docker? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        run_docker
        exit 0
    fi
fi

if command_exists python3; then
    echo "✅ Python 3 is available"
    echo ""
    read -p "🐍 Would you like to use Python HTTP server? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        run_python
        exit 0
    fi
fi

if command_exists node; then
    echo "✅ Node.js is available"
    echo ""
    read -p "🟢 Would you like to use Node.js HTTP server? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        run_node
        exit 0
    fi
fi

# If no tools are available or user declined all
echo ""
echo "❌ No suitable tools found or all options declined."
echo ""
echo "📋 Available options:"
echo "   1. Install Docker: https://docs.docker.com/get-docker/"
echo "   2. Install Python 3: https://www.python.org/downloads/"
echo "   3. Install Node.js: https://nodejs.org/"
echo ""
echo "💡 Or you can manually run any of the specific scripts:"
echo "   ./run-docker.sh   - Run with Docker"
echo "   ./run-python.sh   - Run with Python"
echo "   ./run-node.sh     - Run with Node.js"
echo ""
echo "🌐 You can also simply open index.html directly in your browser!"
