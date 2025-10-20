const http = require('http');

http.get({ hostname: 'localhost', port: 3000, path: '/' }, (res) => {
  console.log('statusCode:', res.statusCode);
  res.setEncoding('utf8');
  res.on('data', d => console.log('body:', d));
}).on('error', e => {
  console.error('error:', e.message);
  process.exit(2);
});
