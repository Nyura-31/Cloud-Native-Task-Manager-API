# Cloud-Native Task Manager API

A production-style RESTful Task Manager API built using **Node.js** and **Express**, designed to demonstrate modern **Cloud** and **DevOps** practices including containerization, cloud deployment, CI/CD, Infrastructure as Code (IaC), and Kubernetes orchestration.

This project is being developed as part of the **Cloud DevOps Bootcamp Capstone Project**.

---

## Project Overview

The Cloud-Native Task Manager API allows users to create, manage, update, and delete tasks through RESTful endpoints. The application is designed following cloud-native principles and is deployed using modern DevOps tools and workflows.

---

## Features

- RESTful Task Management API
- Create, Read, Update, and Delete (CRUD) operations
- JSON-based data storage (or database integration if applicable)
- Docker containerization
- Docker Compose support
- AWS EC2 deployment
- Nginx reverse proxy configuration
- HTTPS using Let's Encrypt (Certbot)
- CI/CD pipeline using GitHub Actions
- Infrastructure provisioning with Terraform
- Kubernetes deployment manifests
- Logging and error handling
- Production-ready project structure

---

## Tech Stack

### Backend
- Node.js
- Express.js

### DevOps
- Git & GitHub
- Linux (Ubuntu)
- Docker
- Docker Compose
- GitHub Actions
- Terraform
- Kubernetes

### Cloud
- Amazon Web Services (AWS EC2)
- Nginx
- Let's Encrypt (Certbot)

---

## API Endpoints

| Method | Endpoint | Description |
|---------|----------|-------------|
| GET | `/tasks` | Retrieve all tasks |
| GET | `/tasks/:id` | Retrieve a specific task |
| POST | `/tasks` | Create a new task |
| PUT | `/tasks/:id` | Update an existing task |
| DELETE | `/tasks/:id` | Delete a task |

---

## Project Structure

```
Cloud-Native-Task-Manager-API/
│
├── src/
│   ├── controllers/
│   ├── routes/
│   ├── middleware/
│   ├── models/
│   └── app.js
│
├── data/
│   └── tasks.json
│
├── terraform/
│
├── kubernetes/
│
├── .github/
│   └── workflows/
│
├── Dockerfile
├── docker-compose.yml
├── nginx.conf
├── package.json
└── README.md
```

---

## Installation

### Clone the repository

```bash
git clone https://github.com/Nyura-31/Cloud-Native-Task-Manager-API.git
```

### Navigate to the project

```bash
cd Cloud-Native-Task-Manager-API
```

### Install dependencies

```bash
npm install
```

### Start the development server

```bash
npm start
```

---

## Linux and Shell Automation

The application code and shell scripts are located in the `TaskManager` directory. Run these commands from that directory on Linux, macOS, or WSL:

```bash
cd TaskManager
chmod +x scripts/*.sh
```

Start the API, installing dependencies only when `node_modules` is missing:

```bash
./scripts/start.sh
```

Install dependencies and verify that a temporary API instance starts and responds to its health endpoint:

```bash
./scripts/build.sh
```

Check the health of an API already running on port 3000:

```bash
./scripts/health-check.sh
```

The health-check script prints `Application is healthy` when `http://localhost:3000/health` is reachable; otherwise it prints `Application is not running` and exits with a non-zero status.

---

## Running with Docker

Build the Docker image:

```bash
docker build -t task-manager-api .
```

Run the container:

```bash
docker run -p 3000:3000 task-manager-api
```

Or use Docker Compose:

```bash
docker-compose up
```

---

## Deployment

The application will be deployed to an AWS EC2 instance using Docker and Nginx, with HTTPS enabled via Let's Encrypt. Infrastructure provisioning is managed using Terraform, and deployment automation is handled through GitHub Actions.

---

## CI/CD Pipeline

The GitHub Actions workflow will:

- Install dependencies
- Build the application
- Run tests
- Build the Docker image
- Deploy the application to AWS

---

## Future Enhancements

- Database integration (MongoDB/PostgreSQL)
- JWT Authentication
- User Management
- API Documentation with Swagger
- Monitoring using Prometheus and Grafana
- Kubernetes Ingress Controller
- Auto Scaling
- Centralized Logging


