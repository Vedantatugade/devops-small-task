pipeline {
    agent any

    stages {

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Get EC2 IP') {
            steps {
                script {
                    EC2_IP = sh(script: "terraform output -raw ec2_ip", returnStdout: true).trim()
                    echo "EC2 Public IP: ${EC2_IP}"
                }
            }
        }

        stage('Run Ansible') {
            steps {
                sh """
                ansible-playbook -i ${EC2_IP}, nginx.yml \
                --private-key my-tf-key.pem \
                -u ubuntu
                """
            }
        }

    }
}