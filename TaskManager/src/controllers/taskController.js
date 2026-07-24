const taskModel = require('../models/taskModel');

const VALID_STATUSES = ['pending', 'completed'];

function getTaskId(value) {
  const id = Number(value);
  return Number.isInteger(id) && id > 0 ? id : null;
}

function isNonEmptyString(value) {
  return typeof value === 'string' && value.trim().length > 0;
}

function validateTaskFields(data, isUpdate = false) {
  const errors = [];
  const hasTitle = Object.prototype.hasOwnProperty.call(data, 'title');
  const hasDescription = Object.prototype.hasOwnProperty.call(data, 'description');
  const hasStatus = Object.prototype.hasOwnProperty.call(data, 'status');

  if (!isUpdate || hasTitle) {
    if (!isNonEmptyString(data.title)) errors.push('title is required');
  }

  if (!isUpdate || hasDescription) {
    if (!isNonEmptyString(data.description)) errors.push('description is required');
  }

  if (hasStatus && !VALID_STATUSES.includes(data.status)) {
    errors.push('status must be pending or completed');
  }

  if (isUpdate && !hasTitle && !hasDescription && !hasStatus) {
    errors.push('provide title, description, or status to update');
  }

  return errors;
}

function getTasks(req, res) {
  res.status(200).json(taskModel.getAllTasks());
}

function getTask(req, res) {
  const id = getTaskId(req.params.id);
  const task = id && taskModel.getTaskById(id);

  if (!task) {
    return res.status(404).json({ message: 'Task not found' });
  }

  return res.status(200).json(task);
}

function createTask(req, res) {
  const errors = validateTaskFields(req.body);

  if (errors.length > 0) {
    return res.status(400).json({ message: errors.join(', ') });
  }

  const task = taskModel.createTask({
    title: req.body.title.trim(),
    description: req.body.description.trim(),
    status: req.body.status || 'pending',
  });

  return res.status(201).json(task);
}

function updateTask(req, res) {
  const id = getTaskId(req.params.id);

  if (!id || !taskModel.getTaskById(id)) {
    return res.status(404).json({ message: 'Task not found' });
  }

  const errors = validateTaskFields(req.body, true);

  if (errors.length > 0) {
    return res.status(400).json({ message: errors.join(', ') });
  }

  const updates = {};
  if (Object.prototype.hasOwnProperty.call(req.body, 'title')) updates.title = req.body.title.trim();
  if (Object.prototype.hasOwnProperty.call(req.body, 'description')) updates.description = req.body.description.trim();
  if (Object.prototype.hasOwnProperty.call(req.body, 'status')) updates.status = req.body.status;

  return res.status(200).json(taskModel.updateTask(id, updates));
}

function removeTask(req, res) {
  const id = getTaskId(req.params.id);
  const deletedTask = id && taskModel.deleteTask(id);

  if (!deletedTask) {
    return res.status(404).json({ message: 'Task not found' });
  }

  return res.status(204).send();
}

module.exports = {
  getTasks,
  getTask,
  createTask,
  updateTask,
  removeTask,
};
