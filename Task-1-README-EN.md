# DevOps Project TASK-1: Modular Virtual Machine Creation on AWS with Terraform and Jenkins

## Purpose
This project involves using Terraform to create modular virtual machines on AWS, automated through Jenkins. Students will configure separate setups for different environments like testing, development, staging, and production.

## Requirements
- AWS account
- Terraform
- Jenkins
- Git and GitHub (or a similar version control system)

## Step-by-Step Tasks

### 1. Project Setup
- **1.1.** Create a repository on GitHub. This repository will contain your Terraform configurations and Jenkinsfile.
- **1.2.** Clone the repository to your local computer.

### 2. Creating Terraform Modules
- **2.1.** Create a Terraform module for each AWS environment (`test`,`dev`, `staging`, `prod`), including resources like EC2 instances, security groups, and IAM roles.
- **2.2.** Define input variables for each module (e.g., instance type, size, environment name).
- **2.3.** Use output variables to provide details of the resources created (e.g., IP addresses of EC2 instances).

### 3. Jenkins Setup and Configuration
- **3.1.** Install Jenkins on an EC2 instance.
- **3.2.** Install the Terraform on an EC2 instance.
- **3.3.** Create a new pipeline in Jenkins and integrate it with your GitHub repository.

### 4. Creating the Jenkins Pipeline
- **4.1.**  Create a Jenkinsfile to define your pipeline. The pipeline will first create project-specific Key Pairs for the EC2 instances, then run Terraform plan and apply commands.
- **4.2.** Add parameters in the pipeline to specify which environment Terraform will run for.
- **4.3.** Set up automatic triggers to run the Jenkins pipeline following changes on GitHub.

### 5. Testing and Verification
- **5.1.** Run `terraform apply` for each environment to verify that your Terraform modules are working.
- **5.2.** Check whether EC2 instances have been successfully created.
- **5.3.** Test whether the Jenkins pipeline works correctly and triggers automatically.

### 6. Documentation and Reporting
- **6.1.** Document every step and configuration used in the project in detail.
- **6.2.** Report any challenges you encountered and how you addressed them.
- **6.3.** Finally, prepare a report detailing the resources created.

