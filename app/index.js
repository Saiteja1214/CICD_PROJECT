const http = require('http');
const port = process.env.PORT || 3000;
const server = http.createServer((req, res) => {
  res.end('Hello from cicd-sample-app at ' + new Date().toISOString());
});
server.listen(port, () => console.log(`Server listening on ${port}`));
