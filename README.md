# Board Game Database - DevSecOps Pipeline

## Overview
This project is a full-stack Java Spring Boot web application deployed to an Amazon EKS (Kubernetes) cluster using a fully automated DevSecOps CI/CD pipeline. All underlying AWS infrastructure is provisioned as code using Terraform.

## Tech Stack
* **Cloud & Infrastructure:** AWS (EC2, EKS), Terraform
* **CI/CD & Security:** Jenkins, Docker, Trivy, SonarQube, Nexus
* **Monitoring:** Prometheus, Grafana
* **Application:** Java, Spring Boot, Maven, H2 Database

## Pipeline Workflow
1. **Code Commit:** Pushing code to GitHub automatically triggers the Jenkins pipeline.
2. **Build & Test:** Maven compiles the code and runs unit tests.
3. **Quality Check:** SonarQube scans the code to enforce quality standards.
4. **Artifact Storage:** The compiled `.jar` file is saved in Nexus.
5. **Containerization:** Docker packages the application into an image.
6. **Security Scan:** Trivy scans the Docker image and blocks the build if high/critical vulnerabilities are found.
7. **Deployment:** The secure image is pushed to DockerHub and deployed to the Amazon EKS cluster.

## How to Run & Deploy

**1. Provision Infrastructure**
* Ensure the AWS CLI and Terraform are installed.
* Open the `/terraform` folder.
* Run `terraform init`, `terraform plan`, and `terraform apply` to create the AWS servers.

**2. Run the Pipeline**
* Add your AWS, DockerHub, and Nexus credentials to Jenkins.
* Create a pipeline job using the `Jenkinsfile` in this repository and trigger the build.

**3. Local Testing**
* Run the Spring Boot application in your local IDE.
* Use these default credentials to test the role-based login:
  * **User Role:** username: `bugs` | password: `bunny`
  * **Manager Role:** username: `daffy` | password: `duck`