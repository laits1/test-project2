pipeline {
  agent any

  environment {
    GIT_URL = "https://github.com/laits1/test-project2.git"
    HOME = "/var/lib/jenkins"
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
		sh 'curl https://sdk.cloud.google.com | bash'
		sh 'exec -l $SHELL'
		sh 'gcloud init --console-only'

		sh 'gcloud config set auth/disable_scopes true'
		sh 'gcloud config set project test-project2-394700'
                 }
        }


        stage('Create VM') {
            steps {
                sh 'gcloud compute instances create gcloud-vm --machine-type e2-medium --zone=asia-northeast3-a'
            }
        }
  }
}

