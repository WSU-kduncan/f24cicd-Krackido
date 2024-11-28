
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

