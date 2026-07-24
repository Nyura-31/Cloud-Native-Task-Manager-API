require('dotenv').config();

const app = require('./app');

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Task Manager API listening on port ${PORT}`);
});

app.get("/", (req, res) => {
  res.json({
    application: "Cloud-Native Task Manager API",
    status: "Running",
    version: "1.0.0",
  });
});
