#!/bin/bash

# Catppuccin Mocha Portfolio Website - Docker Runner
# This script builds and runs the website using Docker with nginx

echo "🎨 Starting Catppuccin Mocha Portfolio Website with Docker..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    echo "   Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Build the Docker image
echo "🔨 Building Docker image..."
docker build -t portifolio .

if [ $? -ne 0 ]; then
    echo "❌ Failed to build Docker image"
    exit 1
fi

# Stop any existing container with the same name
echo "🛑 Stopping any existing container..."
docker stop portifolio-container 2>/dev/null || true
docker rm portifolio-container 2>/dev/null || true

# Run the container
echo "🚀 Starting website container..."
docker run -d \
    --name portifolio-container \
    -p 8080:80 \
    portifolio

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Website is now running!"
    echo "🌐 Open your browser and go to: http://localhost:8080"
    echo ""
    echo "📋 Container management commands:"
    echo "   Stop:  docker stop portifolio-container"
    echo "   Logs:  docker logs portifolio-container"
    echo "   Remove: docker rm portifolio-container"
    echo ""
else
    echo "❌ Failed to start container"
    exit 1
fi
