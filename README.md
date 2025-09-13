# Hello World Node.js App with CI& Terraform Deployment
A simple Node.js application that serves `"Hello World"` — now containerized, linted, and deployed using a CI pipeline and Terraform.

This simple **Node.js Hello World Node** web application, designed to demonstrate the full DevOps lifecycle:

- App containerization with Docker  
- CI/CD pipeline using GitHub Actions  
- Docker image published to Docker Hub  
- Local container deployment using Terraform Docker provider  
- Optional: Monitoring setup with New Relic


## Features

- Node.js Express app that returns `Hello Node`
- ESLint for code linting
- JSON linting support
- Dockerized app with exposed port `3000`
- GitHub Actions pipeline:
  - Linting
  - Docker build
  - Docker push
- Terraform deployment using local Docker provider

## Project Structure

.
├── .github/workflows/cicd.yaml # GitHub Actions CI/CD pipeline
├── Dockerfile # Docker configuration
├── main.tf # Terraform config (Docker provider)
├── newrelic.js # New Relic config (uses GitHub secret)
├── .eslintrc.json # ESLint configuration
├── .pre-commit-config.yaml # Pre-commit hooks
├── index.js # Node.js app entry point
├── package.json # Node dependencies and scripts
└── README.md # Project documentation

## Installation & Setup

### Prerequisites

- Node.js (v16+)
- Docker installed and running
- Terraform installed
- GitHub CLI or access to your repository


## Run Locally

1. Fork repo to my your github account and Clone the repo:
   using bash/linux terminal or cloning forexample on Visual Studio Code
   git clone https://github.com/yourusername/node-hello.git
   cd node-hello

2. Install dependencies:
npm ci

3. Run the app:
npm start

4. Open in browser:
http://localhost:3000

## Docker

You can build and run the app with Docker:
docker build -t hello-world-node .
docker push dockerhub_udername/hello-world-node (for pushing manually to docker hub)
docker run -p 3000:3000 hello-world-node

## CI Pipeline (GitHub Actions)

This project uses GitHub Actions for CI. The pipeline runs on push or pull_request to main or testing-branch.
Steps:

    Checkout code
    Set up Node.js
    Install dependencies
    Run ESLint
    Login to Docker Hub
    Build Docker image (injecting New Relic license via secret)
    Push image to Docker Hub

File:
.github/workflows/ci.yaml


## Terraform Deployment (Local Docker Provider)

Deploy the app as a container on your local machine using Terraform:
1. Initialize Terraform:
terraform init
2. Apply the deployment:
terraform apply
The app will be running on http://localhost:3000

Note: Make sure port 3000 is not in use by another process

3. Destroy deployment:
terraform destroy

## Monitoring using New Relic

Monitoring is integrated via the newrelic.js file.
The license key is injected via GitHub Secrets (NEW_RELIC_LICENSE_KEY)
Make sure you’ve set up New Relic and created a free-tier account

## Linting & Code Quality
ESLint Configured in .eslintrc.json
Run it manually:
npm run lint

JSON Lint Installed via jsonlint for checking JSON files

Pre-commit Hook
Defined in .pre-commit-config.yaml:
Automatically lints JavaScript files before each commit
Install with:
pre-commit install

## Secrets Used

Set these secrets in your GitHub repo:
Secret Name	            Description
DOCKER_USERNAME	        Your Docker Hub username
DOCKER_PASSWORD	        Your Docker Hub password or token
NEW_RELIC_LICENSE_KEY	  New Relic ingest license key

## Assumptions Made

    -App is deployed locally using the Docker provider (no cloud provider used)
    -No external database or stateful service required
    -New Relic setup is optional (but configured)
    -CI/CD focuses on build, test, and image push (not production deployment)
    -Terraform deployment runs locally, not from the GitHub Actions pipeline
    -App listens on port 3000.

## Author
Raghda Sallam
GitHub: @RaghdaSallam











