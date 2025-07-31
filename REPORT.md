# DevOps Case Study

## Overview

This project demonstrates a complete DevOps pipeline, including infrastructure provisioning, configuration management, application deployment, and CI/CD automation using Terraform, Ansible, Docker, and Jenkins on AWS.

---

## Architecture

- Provision EC2 instances on AWS using Terraform (Ubuntu 22.04 LTS in default VPC)
- Configure instances with Ansible to install Docker and deploy a Node.js app inside a container
- Build and push Docker images to DockerHub
- Use Jenkins CI/CD pipeline to automate build, infrastructure provisioning, and deployment

---

## Features

- Dynamic AMI lookup via AWS SSM Parameter Store for region compatibility
- Dockerized Node.js app deployment
- Declarative infrastructure as code with Terraform
- Configuration management using Ansible playbooks
- Jenkins pipeline orchestrating end-to-end build, deploy, and infra provisioning
- Shell cleanup scripts for Docker resource management

---

## Prerequisites

- AWS account with necessary permissions
- AWS CLI configured locally or on your EC2 workstation
- Terraform installed (version 1.3+ recommended)
- Ansible installed
- Docker Hub account and repository created
- Jenkins server running on EC2 with necessary plugins (Git, Docker, Ansible, Terraform)
- SSH key pairs for ec2 instances

---

## Repository Structure

devops-case-study/
│
├── ansible/
│ ├── deploy.yml # Ansible playbook for app deployment
│ └── hosts.ini # Ansible inventory with target EC2 IP
│
├── infra/
│ ├── main.tf # Terraform config files
│ └── variables.tf # Terraform variables (if any)
│
├── scripts/
│ └── cleanup.sh # Shell script to cleanup dangling Docker resources
│
├── Jenkinsfile # Declarative pipeline for Jenkins
├── REPORT.md # Project report and documentation
└── README.md # This file


---

## Usage

### 1. Terraform Infrastructure Provisioning

cd infra
terraform init
terraform apply -auto-approve

- Creates EC2 instance in AWS with dynamic Ubuntu AMI
- Outputs public IP address for deployment and SSH

### 2. Ansible Configuration and Deployment

- Update `ansible/hosts.ini` to use your EC2 public IP and path to SSH private key
- Run playbook:
ansible-playbook -i ansible/hosts.ini ansible/deploy.yml

This will install Docker, start your Node.js app container pulling the proper Docker image.

### 3. Docker Image Build & Push

- Build the Docker image locally or on your DevOps workstation:

docker build -t <dockerhub-username>/myapp:<tag> .
docker push <dockerhub-username>/myapp:<tag>


Replace `<tag>` to match your app version or commit SHA.

### 4. Jenkins Pipeline

- Configure Jenkins on your EC2 server.
- Create pipeline job using `Pipeline script from SCM` pointing to this repo.
- Configure credentials for DockerHub, AWS, and GitHub in Jenkins.
- Run the pipeline to automate build, push, Terraform apply, and Ansible deploy.

### 5. Cleanup Docker Resources

Run cleanup script to free Docker space on your EC2:

./scripts/cleanup.sh


---

## Important Notes and Tips

- Never commit `.terraform/` directories or `.tfstate` files to Git.
- Always use `.gitignore` to exclude local environment and cache files.
- Remember to update your Jenkins user permissions to run Docker commands:

sudo usermod -aG docker jenkins
sudo systemctl restart jenkins


- Use SSH keys carefully; keep private keys secure and never commit them to source control.
- Stay mindful of AWS security groups—keep ports minimal and restrict IP access in production.
- Use the latest Docker image tags to avoid deployment mismatches.

---

## Troubleshooting

- If Terraform errors occur, check AWS region and valid AMI IDs (use SSM lookup).
- Fix Ansible SSH issues by confirming correct private key path and permissions.
- Docker permission errors resolved by adding users to `docker` group and re-logging.
- Jenkins pipeline SCM errors fixed by setting job type to “Pipeline script from SCM.”
- Large file GitHub push errors resolved by ignoring `.terraform` and cleaning history.

---

## Links and Resources

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)
- [Docker Official Docs](https://docs.docker.com/)
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Git Large File Storage](https://git-lfs.github.com/)
- [AWS EC2 Security Groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-security-groups.html)

---

## Author

**Your Name / GitHub Username: aman08-cool**

Repository URL: https://github.com/aman08-cool/devops-case-study

---

## License

MIT License (update if applicable)

---

*This README is part of a learning DevOps project implementing CI/CD best practices with Terraform, Ansible, Docker, and Jenkins on AWS.*


