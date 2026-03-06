pipeline {
    agent any

    stages {

        stage('Terraform Init') {
            steps {
                bat 'terraform init'
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws-credentials-1',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    bat 'terraform apply -auto-approve'
                }
            }
        }

        stage('Get EC2 IP') {
            steps {
                bat 'terraform output -raw ec2_ip > ip.txt'
            }
        }

        stage('Create Inventory File') {
            steps {
                bat 'echo [web] > inventory.ini'
                bat 'for /f %%i in (ip.txt) do echo %%i ansible_user=ec2-user ansible_ssh_private_key_file=small-task.pem >> inventory.ini'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                bat 'wsl ansible-playbook -i inventory.ini nginx.yaml'
            }
        }

    }
}