import { createServer } from 'http';

const server = createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(`
    <html>
      <body style="background:blue; color:white; text-align:center; padding:50px">
        <h1>Version 1 - BLUE Environment</h1>
        <p>This is the current live version</p>
      </body>
    </html>
  `);
});

server.listen(8080, () => console.log('Blue app running on port 8080'));