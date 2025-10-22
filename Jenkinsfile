pipeline {
    agent any

    environment {
        // Jenkins API token
        JENKINS_API_TOKEN = credentials('JENKINS_API_TOKEN')
        // Jenkins username + password
        JENKINS_USER = credentials('JENKINS_USER')
        // Optional GitHub token if your repo is private
        // GITHUB_TOKEN = credentials('JenkinsusingDock')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out repository..."
                checkout scm
            }
        }

        stage('Test Terraform') {
            steps {
                echo "Testing Terraform installation..."
                sh 'terraform --version'
            }
        }

        stage('Test Ansible') {
            steps {
                echo "Testing Ansible installation in virtual environment..."
                sh '''
                    source /opt/ansible-venv/bin/activate
                    ansible --version
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully! ✅"
        }
        failure {
            echo "Pipeline failed! ❌ Check logs."
        }
    }
}
