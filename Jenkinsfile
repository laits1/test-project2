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

stage('Set gcloud Config') {
    steps {
        script {
            // google-cloud-sdk 디렉토리가 존재하면 삭제
            def gcloudSdkDir = "${HOME}/google-cloud-sdk"
            if (fileExists(gcloudSdkDir)) {
                sh "rm -rf ${gcloudSdkDir}"
            }
        }

        // gcloud SDK 설치 및 환경 설정
        sh 'curl https://sdk.cloud.google.com | bash'

        // GCP 서비스 계정 자격증명 설정
        withCredentials([file(credentialsId: CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
            sh "gcloud auth activate-service-account --key-file=\$GOOGLE_APPLICATION_CREDENTIALS"
        }

        // GCP 프로젝트 ID 설정 및 프롬프트 비활성화
        sh "gcloud config set project ${GCP_PROJECT_ID} --quiet"
        sh "gcloud config set disable_prompts true --quiet"
    }
}

        stage('Create VM') {
            steps {
                sh "gcloud compute instances create gcloud-vm --machine-type=e2-medium --zone=${GCP_ZONE}"
            }
        }
    }
}

