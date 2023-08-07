pipeline {
  agent any

  environment {
    GIT_URL = "https://github.com/laits1/test-project2.git"
    HOME = "/var/lib/jenkins"
    GCLOUD_PATH = "/var/lib/jenkins/gcs/google-cloud-sdk" // 새로운 설치 경로로 변경하세요.
    GCLOUD_PROJECT = "test-project2-394700" // 변경할 GCP 프로젝트명으로 변경하세요.
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
	  sh 'rm -rf /var/lib/jenkins/google-cloud-sdk'
          sh 'curl https://sdk.cloud.google.com | bash'
          sh 'export PATH=$PATH:$GCLOUD_PATH/bin' // Google Cloud SDK가 설치된 디렉토리를 PATH에 추가합니다.
          sh 'gcloud config set pass_credentials_to_gsutil false'
          sh 'gcloud init --console-only'
          sh 'gcloud config set auth/disable_scopes true'
          sh "gcloud config set project ${GCLOUD_PROJECT}" // 변경된 GCP 프로젝트명을 설정합니다.
        }
      }
    }

    stage('Create VM') {
      steps {
        sh 'gcloud compute instances create gcloud-vm --machine-type e2-medium --zone=asia-northeast3-a'
      }
    }
  }
}
