pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Test Terraform') {
            steps {
                sh 'terraform --version'
            }
        }
        stage('Test Ansible') {
            steps {
                sh 'ansible --version'
            }
        }
    }
}
