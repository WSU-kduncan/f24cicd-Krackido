# Continuous Deployment 

Overview Here

### Tools Used:
1. **Git**: To manage version control and tagging of releases.
2. **GitHub Actions**: To automate the CI/CD pipeline, building, tagging, and pushing Docker images.
3. **Docker**: To containerize the application and ensure it runs.
4. **DockerHub**: To host and share Docker images.

### How to Generate and Push a Tag in Git

1. **Create a Tag**:
   Use the following command to create a new tag with your desired version number (e.g., `1.0.0`):
   ```bash
   git tag vX.Y.Z -am "Release description"
   git push origin vX.Y.Z
   ```

### Behavior of Workflow

The workflow is triggered whenever a new git tag is pushed to the repository that matches the v*.*.* pattern.

### What Does the Workflow Do?
1. Checkout Code: Pulls the repository's latest code.
2. Set Up QEMU: Configures the build environment for multi-platform compatibility.
3. Set Up Docker Buildx: Prepares Docker for advanced image building.
4. Login to DockerHub: Authenticates with DockerHub using stored secrets (DOCKERHUB_USERNAME and DOCKERHUB_TOKEN).
5. Generate Image Tags: Extracts semantic version tags (e.g., latest, major, major.minor) from the git tag.
6. Build and Push Docker Image: Builds the Docker image from the repository's Dockerfile and pushes it to DockerHub with all generated tags.
7. Link to Dockerhub Repo: https://hub.docker.com/repository/docker/patel513/app/general

### Instance information
1. Public IP: 34.233.82.151
2. OS : Ubuntu 24.04.1

### How to install docker
1. `sudo apt update`
2. `sudo apt-get install docker.io`
3. `sudo systemctl start docker`


