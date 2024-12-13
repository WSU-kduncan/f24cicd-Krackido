# **Continuous Deployment**

Develop and deploy a CI/CD pipeline integrating semantic versioning, GitHub Actions, DockerHub, and webhooks to automate containerized application deployments on an EC2 instance.

---

## **Tools Used**
1. **Git**: For version control and tagging releases.
2. **GitHub Actions**: Automates the CI/CD pipeline for building, tagging, and pushing Docker images.
3. **Docker**: Containerizes the application to ensure consistent environments.
4. **DockerHub**: Hosts and shares Docker images.

---

## **How to Generate and Push a Tag in Git**
1. **Create a Tag**:
   ```bash
   git tag vX.Y.Z -am "Release description"
   git push origin vX.Y.Z
   ```

---

## **Behavior of Workflow**

### **Trigger**
The workflow is triggered whenever a new Git tag following the `v*.*.*` pattern is pushed to the repository.

### **Steps in the Workflow**
1. **Checkout Code**: Pulls the repository's latest code.
2. **Set Up QEMU**: Configures the environment for multi-platform compatibility.
3. **Set Up Docker Buildx**: Prepares Docker for advanced image building.
4. **Login to DockerHub**: Authenticates using stored secrets (`DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN`).
5. **Generate Image Tags**: Creates semantic version tags (e.g., `latest`, `major`, `major.minor`) based on Git tag metadata.
6. **Build and Push Docker Image**: Builds the Docker image and pushes it to DockerHub with all generated tags.
7. **DockerHub Repository**: [DockerHub Repo Link](https://hub.docker.com/repository/docker/patel513/app/general)

---

## **Instance Information**
- **Public IP**: `34.233.82.151`
- **OS**: Ubuntu 24.04.1

---

## **How to Install Docker**
1. Update the system:
   ```bash
   sudo apt update
   ```
2. Install Docker:
   ```bash
   sudo apt-get install docker.io
   ```
   - Obtained from: [Source](https://askubuntu.com/questions/938700/how-do-i-install-docker-on-ubuntu-16-04-lts)
3. Start Docker:
   ```bash
   sudo systemctl start docker
   ```

---

## **Bash Script**
1. **Purpose**:
   Automates updating the website by:
   - Stopping and removing the current Docker container.
   - Pulling the latest image from DockerHub.
   - Running a new container with the latest image.

2. **Location**: `/home/ubuntu/refresh.sh`

3. **Link to Script**: [refresh.sh](https://github.com/WSU-kduncan/f24cicd-Krackido/blob/main/deployment/refresh.sh)
   - Credit for script to professor Duncan class 12/02/24

---

## **Installing `webhook`**
1. **Purpose**:
   Automates triggering the Bash script when new updates are pushed to GitHub or DockerHub.

2. **Installation Steps**:
   - Update system packages:
     ```bash
     sudo apt update
     ```
   - Install `webhook`:
     ```bash
     sudo apt-get install webhook
     ```
- Installion instruction and webhook from [Source](https://github.com/adnanh/webhook)

---

## **Webhook File**
1. **Key Configuration**:
   - **ID**: A unique identifier for the webhook.
     ```json
     "id": "project-webhook"
     ```
   - **Execute Command**: Specifies the script to execute.
     ```json
     "execute-command": "/home/ubuntu/refresh.sh"
     ```
   - **Working Directory**: Directory in which the command is executed.
     ```json
     "command-working-directory": "/home/ubuntu"
     ```

2. **Link to Webhook File**: [hooks.json](https://github.com/WSU-kduncan/f24cicd-Krackido/blob/main/deployment/hooks.json)
   - Credit for hook file to professor Duncan class 12/04/24

---

## **How to Start Service and Test the Listener**
1. Start the webhook listener:
   ```bash
   webhook -hooks /home/ubuntu/hooks.json -verbose
   ```
2. Test the listener:
   ```bash
   curl http://34.201.180.166:9000/hooks/project-webhook
   ```
3. Monitor logs:
   - Use the `-verbose` flag to view detailed trigger responses.
4. Verify running Docker containers:
   ```bash
   docker ps
   ```
   Check if a new container has started successfully.

---

## **Configuring GitHub Webhook**
1. **Navigate to Repository Settings**:
   - Open the GitHub repository and go to **Settings** > **Webhooks**.

2. **Add a Webhook**:
   - **Payload URL**: 
     ```plaintext
     http://34.201.180.166:9000/hooks/project-webhook?token=your_secret_token
     ```
   - **Content Type**: Select `application/json`.
   - **Secret**: Use a matching secret token from your `hooks.json`.
   - **Events**: Choose events (e.g., `push`) to trigger the webhook.
   - Save the webhook.

---

## **Configuring DockerHub Webhook**
1. **Log in to DockerHub** and navigate to the repository.
2. **Go to Settings > Webhooks**.
3. **Add a New Webhook**:
   - **Webhook URL**: 
     ```plaintext
     http://34.201.180.166:9000/hooks/project-webhook
     ```
   - Save the webhook.

---

## **Modify and Create Webhook Service File**
1. Open the service file for editing:
   ```bash
   sudo vim /usr/lib/systemd/system/webhook.service
   ```

2. Add the following content:
   ```ini
   [Unit]
   Description=Small service for creating HTTP endpoints (hooks)
   Documentation=https://github.com/adnanh/webhook/
   ConditionPathExists=/home/ubuntu/hooks.json

   [Service]
   ExecStart=/usr/bin/webhook -nopanic -hooks /home/ubuntu/hooks.json

   [Install]
   WantedBy=multi-user.target
   ```

3. Restart the service:
   ```bash
   sudo systemctl restart webhook
   ```

4. **Link to Webhook Service File**: [webhook.service](https://github.com/WSU-kduncan/f24cicd-Krackido/blob/main/deployment/webhook.service)
   - Credit for file changes to professor Duncan class 12/04/24

