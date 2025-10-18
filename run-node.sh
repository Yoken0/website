#!/bin/bash

# Catppuccin Mocha Portfolio Website - Node.js HTTP Server
# This script runs the website using Node.js with a simple HTTP server

echo "🎨 Starting Catppuccin Mocha Portfolio Website with Node.js..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

# Check if index.html exists
if [ ! -f "index.html" ]; then
    echo "❌ index.html not found in current directory"
    exit 1
fi

# Create a temporary server script
cat > temp-server.js << 'EOF'
const http = require('http');
const fs = require('fs');
const path = require('path');

const port = 8085;

// MIME types for different file extensions
const mimeTypes = {
    '.html': 'text/html',
    '.js': 'text/javascript',
    '.css': 'text/css',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpg',
    '.gif': 'image/gif',
    '.svg': 'image/svg+xml',
    '.wav': 'audio/wav',
    '.mp4': 'video/mp4',
    '.woff': 'application/font-woff',
    '.ttf': 'application/font-ttf',
    '.eot': 'application/vnd.ms-fontobject',
    '.otf': 'application/font-otf',
    '.wasm': 'application/wasm'
};

const server = http.createServer((req, res) => {
    // Remove query string and decode URL
    let filePath = decodeURIComponent(new URL(req.url, `http://localhost:${port}`).pathname);
    
    // If it's the root path, serve index.html
    if (filePath === '/') {
        filePath = '/index.html';
    }
    
    // Get the full file path
    const fullPath = path.join(__dirname, filePath);
    
    // Get file extension
    const extname = path.extname(fullPath).toLowerCase();
    const contentType = mimeTypes[extname] || 'application/octet-stream';
    
    // Check if file exists
    fs.readFile(fullPath, (error, content) => {
        if (error) {
            if (error.code === 'ENOENT') {
                // File not found
                res.writeHead(404, { 'Content-Type': 'text/html' });
                res.end(`
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <title>404 - Not Found</title>
                        <style>
                            body { 
                                font-family: 'Inter', sans-serif; 
                                background-color: #1e1e2e; 
                                color: #cdd6f4; 
                                text-align: center; 
                                padding: 50px;
                            }
                            h1 { color: #f38ba8; }
                        </style>
                    </head>
                    <body>
                        <h1>404 - Page Not Found</h1>
                        <p>The requested file could not be found.</p>
                        <a href="/" style="color: #cba6f7;">← Back to Home</a>
                    </body>
                    </html>
                `);
            } else {
                // Server error
                res.writeHead(500);
                res.end('Server Error: ' + error.code);
            }
        } else {
            // File found
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content, 'utf-8');
        }
    });
});

server.listen(port, () => {
    console.log(`✅ Website is now running!`);
    console.log(`🌐 Open your browser and go to: http://localhost:${port}`);
    console.log(`🛑 Press Ctrl+C to stop the server`);
});

// Handle graceful shutdown
process.on('SIGINT', () => {
    console.log('\n🛑 Shutting down server...');
    server.close(() => {
        console.log('✅ Server stopped');
        process.exit(0);
    });
});
EOF

# Start the server
echo "🚀 Starting Node.js HTTP server on port 8085..."
node temp-server.js

# Clean up the temporary file
rm -f temp-server.js
