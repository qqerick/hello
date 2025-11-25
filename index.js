require('newrelic');
const http = require('http');
const port = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  const msg = 'Hello Node!\n'
  res.end(msg);
});

server.on('request', (req, res) => {
  console.log(`${new Date().toISOString()} ${req.method} ${req.url}`);
});

server.listen(port, '0.0.0.0', () => {
  console.log(`Server running on http://0.0.0.0:${port}/`);
});
