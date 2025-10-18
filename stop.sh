#!/bin/bash

# Catppuccin Mocha Portfolio Website - Stop Script
# This script stops any running website containers

echo "🛑 Stopping Catppuccin Mocha Portfolio Website..."

# Stop Docker container if it exists
if command -v docker &> /dev/null; then
    echo "🐳 Checking for Docker containers..."
    
    if docker ps -q -f name=catppuccin-portfolio-container | grep -q .; then
        echo "🛑 Stopping Docker container..."
        docker stop catppuccin-portfolio-container
        docker rm catppuccin-portfolio-container
        echo "✅ Docker container stopped and removed"
    else
        echo "ℹ️  No Docker container running"
    fi
else
    echo "ℹ️  Docker not available"
fi

echo ""
echo "✅ All website instances stopped!"
echo "💡 Note: If you're running Python or Node.js servers manually,"
echo "   please stop them with Ctrl+C in their respective terminals."
