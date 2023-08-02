pipeline {
  agent any

  environment {
    GIT_URL = "https://github.com/laits1/test-project2.git"
    GOOGLE_APPLICATION_CREDENTIALS = "/home/thsehdrl94/test/jenkins-sa.json"
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
		// gcloud SDK 설치 및 초기화
		sh 'curl https://sdk.cloud.google.com | bash'
		sh 'exec -l $SHELL'
		sh 'gcloud init --console-only'
	    }
	}

        stage('Create VM') {
            steps {
                sh 'gcloud compute instances create gcloud-vm --machine-type e2-medium --zone=asia-northeast3-a'
            }
        }
  }
}

