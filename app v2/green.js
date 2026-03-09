import { createServer } from 'http';

const server = createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(`
    <html>
      <body style="background:green; color:white; text-align:center; padding:50px">
        <h1>Version 2 - GREEN Environment</h1>
        <p>This is the new version being deployed</p>
      </body>
    </html>
  `);
});

server.listen(8080, () => console.log('Green app running on port 8080'));