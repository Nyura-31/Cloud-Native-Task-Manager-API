const tasks = [];
let nextId = 1;

function getAllTasks() {
  return tasks;
}

function getTaskById(id) {
  return tasks.find((task) => task.id === id);
}

function createTask({ title, description, status = 'pending' }) {
  const task = {
    id: nextId,
    title,
    description,
    status,
    createdAt: new Date().toISOString(),
  };

  nextId += 1;
  tasks.push(task);
  return task;
}

function updateTask(id, updates) {
  const task = getTaskById(id);

  if (!task) {
    return null;
  }

  Object.assign(task, updates);
  return task;
}

function deleteTask(id) {
  const taskIndex = tasks.findIndex((task) => task.id === id);

  if (taskIndex === -1) {
    return null;
  }

  return tasks.splice(taskIndex, 1)[0];
}

module.exports = {
  getAllTasks,
  getTaskById,
  createTask,
  updateTask,
  deleteTask,
};
