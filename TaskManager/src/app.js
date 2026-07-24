const express = require('express');
const cors = require('cors');
const tasksRouter = require('./routes/tasks');

const app = express();

app.use(cors());
app.use(express.json());

app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    message: 'Task Manager API Running',
  });
});

app.use('/tasks', tasksRouter);

module.exports = app;
