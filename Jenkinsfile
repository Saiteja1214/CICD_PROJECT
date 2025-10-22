pipeline {
  agent any

  environment {
    PATH = "/opt/ansible-venv/bin:/usr/local/bin:${PATH}"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Test Terraform') {
      steps {
        sh 'terraform --version'
      }
    }

    stage('Test Ansible') {
      steps {
        sh 'ansible-playbook --version'
      }
    }
  }
}
