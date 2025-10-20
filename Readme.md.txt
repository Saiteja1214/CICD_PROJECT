# cicd-project

Local CI/CD demo repo: GitHub Actions → Jenkins → Terraform (Docker) → Ansible → App

Folders:
- app/: Node demo app
- terraform/: terraform code using local docker provider
- ansible/: ansible playbooks to copy app and start it
- .github/workflows/: GitHub Actions workflows
- Jenkinsfile: Jenkins pipeline definition
