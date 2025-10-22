pipeline {
    agent any

    environment {
        // Secret text credential for Jenkins API token (optional use)
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
                    if [ -f /opt/ansible-venv/bin/activate ]; then
                        . /opt/ansible-venv/bin/activate
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
                    credentialsId: 'ISENKINS_USER',   // correct ID
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS')]) {
                        echo "Jenkins username is: $USER"
                        sh 'echo "Password is hidden for security"'
                }
            }
        }
    } // <-- closing brace for stages

    post {
        success {
            echo "Pipeline completed successfully! ✅"
        }
        failure {
            echo "Pipeline failed! ❌ Check logs."
        }
    }
} // <-- closing brace for pipeline
