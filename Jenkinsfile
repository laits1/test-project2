pipeline {
    agent any

    environment {
        GIT_URL = "https://github.com/laits1/test-project2.git"
        HOME = "${WORKSPACE}" // Use the Jenkins workspace as the home directory
        CREDENTIALS_ID = "jenkins-sa.json" // Jenkins Credential Plugin에 등록한 GCP 서비스 계정 키 파일의 credentialsId
        GCP_PROJECT_ID = "test-project2-394700" // GCP 프로젝트 ID
        GCP_ZONE = "asia-northeast3-a" // GCP 인스턴스를 생성할 지역/존 (예: 'us-central1-a', 'asia-northeast3-a' 등)
    }

    stages {
        stage('Pull') {
            steps {
                git(url: "${GIT_URL}", branch: "master", changelog: true, poll: true)
            }
        }

        stage('Setup GCP Configuration') {
            steps {
                withCredentials([file(credentialsId: CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh """
                    curl https://sdk.cloud.google.com | bash
                    gcloud auth activate-service-account --key-file=\$GOOGLE_APPLICATION_CREDENTIALS
                    gcloud config set project ${GCP_PROJECT_ID}
                    """
                }
            }
        }

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

        stage('Create VM') {
            steps {
                sh "gcloud compute instances create gcloud-vm --machine-type=e2-medium --zone=${GCP_ZONE}"
            }
        }
    }
}

