// Path: project/web/Dockerfile

const http = require('http');

const hostname = '0.0.0.0';
const port = 80;

const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello, this is the web server!\n');
    });

server.listen(port, hostname, () => {
    console.log(`Web server running at http://${hostname}:${port}/`);
    });