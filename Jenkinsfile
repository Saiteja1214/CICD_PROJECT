pipeline {
    agent any

    environment {
        JENKINS_API_TOKEN = credentials('11e0d02121894335dfd3c4795db5e25777')
        JENKINS_USER = credentials('JenkinsUsingDocker')
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
