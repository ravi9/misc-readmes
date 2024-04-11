## Basic Commands

1. `docker run <image>`: Run a container from a specified image.
   - `docker run -it <image> /bin/bash`: Run a container interactively with a bash shell.
   - `docker run -d <image>`: Run a container in detached (background) mode.

2. `docker ps`: List running containers.
   - `docker ps -a`: List all containers, including stopped ones.

3. `docker images`: List locally available images.

4. `docker pull <image>`: Pull an image from a Docker registry.

5. `docker stop <container>`: Stop a running container.

6. `docker start <container>`: Start a stopped container.

7. `docker rm <container>`: Remove a stopped container.

8. `docker rmi <image>`: Remove a locally available image.

## Intermediate Commands

9. `docker build`: Build a Docker image from a Dockerfile.
   - `docker build -t <image-name>:<tag> .`: Build an image with a specified name and tag.

10. `docker exec`: Execute a command in a running container.
    - `docker exec -it <container> /bin/bash`: Open an interactive shell in a running container.

11. `docker logs <container>`: View the logs of a container.

12. `docker network`: Manage Docker networks.
    - `docker network create <network-name>`: Create a new Docker network.
    - `docker network connect <network-name> <container>`: Connect a container to a network.

13. `docker volume`: Manage Docker volumes for persistent storage.
    - `docker volume create <volume-name>`: Create a new Docker volume.
    - `docker run -v <volume-name>:<container-path> <image>`: Mount a volume to a container.

14. `docker-compose`: Define and run multi-container applications.
    - `docker-compose up`: Start the services defined in the `docker-compose.yml` file.
    - `docker-compose down`: Stop and remove the services defined in the `docker-compose.yml` file.

## Advanced Commands

15. `docker swarm`: Manage Docker Swarm for container orchestration.
    - `docker swarm init`: Initialize a Docker Swarm.
    - `docker swarm join`: Join a Docker Swarm as a worker node.

16. `docker service`: Manage services in a Docker Swarm.
    - `docker service create`: Create a new service in a Swarm.
    - `docker service scale`: Scale the number of replicas for a service.

17. `docker stack`: Manage Docker Stacks for deploying multi-service applications.
    - `docker stack deploy -c <compose-file> <stack-name>`: Deploy a stack using a Compose file.

18. `docker container prune`: Remove all stopped containers.

19. `docker image prune`: Remove unused images.

20. `docker system prune`: Remove unused containers, images, networks, and volumes.

## Dockerfile

# Use an official Python runtime as the base image
FROM python:3.8

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the working directory
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the working directory
COPY . .

# Expose the port on which the application will run
EXPOSE 5000

# Run the command to start the application
CMD ["python", "app.py"]