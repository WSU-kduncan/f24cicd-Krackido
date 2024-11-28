
# Part 1 Docker-ize it

## 1. Installing Docker and Dependencies on Windows

1. Download the Docker Desktop installer from the Docker website.
2. Run the installer and follow the on-screen instructions.
3. Ensure WSL 2 is installed and enabled as the backend (if not already configured).
4. Verify installation:
   ```
   docker --version
   ```

## 2. Building & Configuring a Container Without an Image

### Steps
1. Install Angular CLI if not already installed:
   ```
   npm install -g @angular/cli
   ```
2. Run the Angular application locally within the container:
   ```
   docker run -it --rm -p 4200:4200 -v $(pwd):/app -w /app node:18-bullseye sh
   npm install
   npm run start
   ```
3. Access the application through `http://localhost:<PORT>`.

## 3. Summary of Instructions in the Repository Dockerfile

- Use Node.js as the base image.
- Copy the Angular application files into the container.
- Install dependencies using `npm install`.
- Serve the Angular application using a development server.

## 4. Building an Image from the Dockerfile

1. Navigate to the project directory containing the Dockerfile.
2. Build the image using:
   ```sh
   docker build -t angular-site .
   ```

## 5. Running a Container from the Built Image

1. Run the container:
   ```sh
   docker run -d -p 4200:4200 angular-site
   ```
2. Access the application by opening a browser and navigating to:
   ```
   http://localhost:4200
   ```

## 6. Viewing the Application in the Container

- Ensure the container is running by checking the status:
  ```sh
  docker ps
  ```
- Open a browser and go to `http://localhost:4200` to view the Angular application.

## 7. Working with DockerHub

### Create a Public Repository in DockerHub
1. Log in to Dockerhub
2. Click "Create Repository" and select "Public".
3. Name your repository and save it.

### Authenticate with DockerHub via CLI
1. Log in to DockerHub using:
   ```
   docker login
   ```
2. Enter your DockerHub username and password.

### Push the Container Image to DockerHub
1. Tag the image:
   ```
   docker tag angular-site <dockerhub-username>/angular-site:latest
   ```
2. Push the image to DockerHub:
   ```
   docker push <dockerhub-username>/angular-site:latest
   ```
3. Link to my Dockerhub repo: https://hub.docker.com/r/patel513/patel-ceg3120

# Part 2 GitHub Actions and Dockerhub

## 1. Configuring GitHub Secrets

### How to Set a Secret for GitHub Actions
1. Go to your GitHub repository.
2. Navigate to **Settings** → **Secrets and variables** → **Actions**.
3. Click **New repository secret**.
4. Enter the **Name** of the secret and its **Value**.
   - For example, `DOCKER_USERNAME` for your DockerHub username.
5. Save the secret by clicking **Add secret**.

### Secrets Set for This Project
- **DOCKER_USERNAME**: The DockerHub username associated with the account.
- **DOCKER_TOKEN**: The DockerHub Access Token with Read/Write permissions.

## 2. Behavior of the GitHub Workflow

### Summary of what workflow does
The workflow automatically builds and pushes a Docker image to DockerHub whenever changes are pushed to the `main` branch. The steps in the workflow are:
1. **Check Out the Code**: Fetches the repository's latest code.
2. **Set Up QEMU**: Prepares the environment for multi-platform builds.
3. **Set Up Buildx**: Configures Docker Buildx for advanced image building.
4. **Login to DockerHub**: Authenticates with DockerHub using secrets.
5. **Build and Push Docker Image**: Builds the Docker image using the `Dockerfile` and pushes it to DockerHub.

[Workflow File](https://github.com/WSU-kduncan/f24cicd-Krackido/blob/main/.github/workflows/dockerflow.yml "File Here")


## 3. Duplicating the Workflow for Your Project

### Summary of Changes Needed
1. **Update DockerHub Secrets**:
   - Set your `DOCKER_USERNAME` and `DOCKER_TOKEN` secrets in the target repository.
2. **Modify the Workflow File**:
   - Update the tags to point to your directory.
3. **Repository Changes**:
   - Include a valid `Dockerfile` at the root of your repository.
   - Ensure the necessary dependencies for your application are installed within the Dockerfile.

