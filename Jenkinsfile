pipeline {
    agent any

    environment {
        // Secret text credential for Jenkins API token (if needed)
        JENKINS_API_TOKEN = credentials('JENKINS_API_TOKEN')
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
            #!/bin/bash
            if [ -f /opt/ansible-venv/bin/activate ]; then
                source /opt/ansible-venv/bin/activate
                ansible --version
            else
                echo "Ansible virtual environment not found!"
                exit 1
            fi
        '''
    }
}


        stage('Use Jenkins User Credential') {
            steps {
                echo "Using Jenkins username/password credential..."
                withCredentials([usernamePassword(
                    credentialsId: 'JenkinsUsingDocker', 
                    usernameVariable: 'USER', 
                    passwordVariable: 'PASS')]) {
                        // Example usage of credentials
                        echo "Jenkins username is: $USER"
                        // Do not echo password in real use; shown here safely
                        sh 'echo "Password is hidden for security"'
                }
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

