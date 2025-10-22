pipeline {
    agent any
    environment {
        TF_WORKDIR = "terraform"
        ANSIBLE_DIR = "ansible"
        // Optional: Jenkins API token stored as Secret Text in Jenkins
        JENKINS_API_TOKEN = credentials('JENKINS_API_TOKEN') 
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Use Jenkins Credentials') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'JENKINS_USER',   
                    usernameVariable: 'JENKINS_USER',
                    passwordVariable: 'JENKINS_PASSWORD')]) {
                        echo "Using Jenkins credentials"
                        sh 'echo "Username is $JENKINS_USER, password is hidden for security"'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.TF_WORKDIR}") {
                    sh 'terraform --version'
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${env.TF_WORKDIR}") {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${env.TF_WORKDIR}") {
                    sh 'terraform apply -input=false -auto-approve tfplan'
                    sh 'terraform output -json > tf-output.json'
                    archiveArtifacts artifacts: 'terraform/tf-output.json', allowEmptyArchive: true
                    sh 'cat tf-output.json'
                }
            }
        }

        stage('Prepare Ansible inventory') {
            steps {
                script {
                    sh '''
                        mkdir -p ansible/inventory
                        python3 - <<'PY'
import json
import os

tf_file = os.path.join("terraform", "tf-output.json")
o = json.load(open(tf_file))

ports = o.get("container_ports", {}).get("value", [])
with open("ansible/inventory/hosts.ini","w") as f:
    f.write("[deployed]\\n")
    for p in ports:
        host_port = p.get("host_port") if isinstance(p, dict) else p
        f.write(f"localhost ansible_connection=local ansible_host=127.0.0.1 ansible_port={host_port}\\n")
print("Wrote ansible/inventory/hosts.ini")
PY
                    '''
                    sh 'cat ansible/inventory/hosts.ini || true'
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                dir('ansible') {
                    sh '''
                      if [ -f /opt/ansible-venv/bin/activate ]; then
                        . /opt/ansible-venv/bin/activate
                      fi
                      ansible-playbook -i inventory/hosts.ini deploy.yml --extra-vars "app_src=${WORKSPACE}/app"
                    '''
                }
            }
        }

        stage('Integration Test') {
            steps {
                sh '''
                  python3 - <<'PY'
import json, sys
import requests

o = json.load(open("terraform/tf-output.json"))
ports = o.get("container_ports", {}).get("value", [])
for p in ports:
    host_port = p.get("host_port") if isinstance(p, dict) else p
    try:
        r = requests.get(f"http://127.0.0.1:{host_port}", timeout=5)
        print(f"Port {host_port} -> {r.status_code} : {r.text[:80]}")
    except Exception as e:
        print("Failed to reach", host_port, e)
        sys.exit(2)
print("Integration tests passed")
PY
                '''
            }
        }

    }

    post {
        success {
            echo 'Pipeline finished successfully. ✅'
        }
        failure {
            echo 'Pipeline failed — investigate! ❌'
        }
    }
}
