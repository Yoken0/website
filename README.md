# 🎨 Catppuccin Mocha Portfolio Website

A beautiful portfolio website featuring the Catppuccin Mocha color scheme - a soothing pastel theme with warm, rich colors.

## 🚀 Quick Start

### Option 1: Smart Runner (Recommended)
```bash
./run.sh
```
This script will automatically detect available tools and guide you through the setup.

### Option 2: Specific Methods

#### With Docker (Production-like)
```bash
./run-docker.sh
```
- Runs on port 8080
- Uses nginx for optimal performance
- Best for production-like testing

#### With Python (Simple)
```bash
./run-python.sh
```
- Runs on port 8000
- Uses Python's built-in HTTP server
- Great for quick development

#### With Node.js (Advanced)
```bash
./run-node.sh
```
- Runs on port 8000
- Custom HTTP server with proper MIME types
- Includes 404 error pages

## 🛑 Stop the Website

```bash
./stop.sh
```

## 📁 Project Structure

```
website/
├── index.html          # Main website file with Catppuccin Mocha styling
├── script.js           # JavaScript functionality
├── dockerfile          # Docker configuration for nginx
├── run.sh              # Smart runner script
├── run-docker.sh       # Docker-specific runner
├── run-python.sh       # Python HTTP server runner
├── run-node.sh         # Node.js HTTP server runner
├── stop.sh             # Stop all running instances
└── README.md           # This file
```

## 🎨 Color Scheme

The website uses the complete Catppuccin Mocha palette:

- **Base**: `#1e1e2e` - Main background
- **Surface**: `#313244`, `#45475a` - Card backgrounds
- **Text**: `#cdd6f4`, `#a6adc8` - Text hierarchy
- **Accent**: `#cba6f7` - Mauve highlights
- **Success**: `#a6e3a1` - Green feedback

## 🌐 Access

Once running, open your browser to:
- **Docker**: http://localhost:8080
- **Python/Node.js**: http://localhost:8000

## 💡 Tips

- The smart runner (`./run.sh`) is the easiest way to get started
- Docker provides the most production-like environment
- Python is the simplest for quick testing
- You can also open `index.html` directly in your browser for basic viewing

## 🔧 Requirements

- **Docker**: Any modern Docker installation
- **Python**: Python 3.x (usually pre-installed on macOS/Linux)
- **Node.js**: Node.js 12+ (optional)

Enjoy your beautiful Catppuccin Mocha portfolio! ☕
