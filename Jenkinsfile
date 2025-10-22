pipeline {
    agent any

    environment {
        // Secret text for Jenkins API token (can be used if needed)
        JENKINS_API_TOKEN = credentials('JENKINS_API_TOKEN')
        // You can add more secret text credentials here if needed
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
                echo "Testing Jenkins username/password credential..."
                withCredentials([usernamePassword(
                    credentialsId: 'JenkinsUsingDocker', 
                    usernameVariable: 'USER', 
                    passwordVariable: 'PASS')]) {
                        // Example usage — avoid printing real password in production!
                        echo "Jenkins username is: $USER"
                        sh 'echo "Password is hidden for safety"'
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
