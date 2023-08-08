pipeline {
    agent any

    environment {
        GIT_URL = "https://github.com/laits1/test-project2.git"
        HOME = "${WORKSPACE}"
        CREDENTIALS_ID = "jenkins-sa.json"
    }

    stages {
        stage('Pull') {
            steps {
                git(url: "${GIT_URL}", branch: "master", changelog: true, poll: true)
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([file(credentialsId: CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([file(credentialsId: CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
    steps {
        withCredentials([file(credentialsId: CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
            sh 'terraform apply -auto-approve'
        }
    }
}

        stage('Set gcloud Config') {
            steps {
                withCredentials([file(credentialsId: CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'chmod +x ./set_gcloud_config.sh'
                    sh './set_gcloud_config.sh'
                }
            }
        }

        stage('Create VM') {
            steps {
                withCredentials([file(credentialsId: CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'chmod +x ./create_vm.sh'
                    sh './create_vm.sh'
                }
            }
        }
    }
}

