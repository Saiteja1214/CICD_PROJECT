pipeline {
    agent any

    environment {
        // Use Jenkins credentials if needed in scripts
        JENKINS_API_TOKEN = credentials('11e0d02121894335dfd3c4795db5e25777')
        JENKINS_USER = credentials('JenkinsUsingDocker')
        // Optional GitHub token if you add private repo access later
        // GITHUB_TOKEN = credentials('GITHUB_TOKEN')
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

        // Optional: Add Terraform plan stage
        stage('Terraform Plan') {
            steps {
                echo "Running Terraform plan..."
                sh '''
                    terraform init
                    terraform plan
                '''
            }
        }

        // Optional: Add Ansible playbook stage
        stage('Ansible Playbook') {
            steps {
                echo "Running Ansible playbook..."
                sh '''
                    source /opt/ansible-venv/bin/activate
                    ansible-playbook playbook.yml -i inventory.ini
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
