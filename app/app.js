// Path: project/app/Dockerfile

const express = require('express');
const app = express();
const port = 3000;

// Define the route for the app server
app.get('/', (req, res) => {
  res.send('Hello, this is the app server!');
});

// Start the app server
app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});


