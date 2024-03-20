```markdown
# Docker Swarm Deployment with Terraform

This repository contains a Terraform configuration for deploying a Docker Swarm cluster.

## Prerequisites

- Docker installed on your machine
- Terraform v0.12 or later

## Docker Images

The configuration uses the following Docker images:

- `nginx:latest` for the app and web services
- `mysql:5.7` for the db service

Ensure these images are available in your Docker environment.

## Usage

1. Clone the repository:

```bash
git clone https://github.com/ozzyib/webapp.git
```

2. Navigate to the repository directory:

```bash
cd yourrepository
```

3. Initialize Terraform:

```bash
terraform init
```

4. Apply the Terraform configuration:

```bash
terraform apply
```

Terraform will output the IDs of the created resources.

## Services

The configuration deploys the following services:

- `app`: A service running the `nginx:latest` Docker image
- `db`: A service running the `mysql:5.7` Docker image
- `web`: A service running the `nginx:latest` Docker image, with 3 replicas

Each service is connected to a Docker network named `webapp_network`.



```markdown
## Docker Commands

Here are some Docker commands you might find useful:

- **Pull Docker images**: Before running the Terraform configuration, ensure the necessary Docker images are available in your Docker environment:

  ```bash
  docker pull nginx:latest
  docker pull mysql:5.7
  ```

- **List Docker services**: After applying the Terraform configuration, you can list the running Docker services:

  ```bash
  docker service ls
  ```

- **Inspect a Docker service**: To inspect a Docker service and see its details:

  ```bash
  docker service inspect <service_name>
  ```

  Replace `<service_name>` with the name of the service you want to inspect (e.g., `app`, `db`, or `web`).

- **View logs for a Docker service**: To view the logs for a Docker service:

  ```bash
  docker service logs <service_name>
  ```

  Replace `<service_name>` with the name of the service whose logs you want to view.

- **Remove a Docker service**: To remove a Docker service:

  ```bash
  docker service rm <service_name>
  ```

  Replace `<service_name>` with the name of the service you want to remove. Note that this will stop and remove the service, and it should be used with caution.
```

These commands should help you manage the Docker services created by the Terraform configuration.