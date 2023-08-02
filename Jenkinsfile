pipeline {
  agent any

  environment {
    GIT_URL = "https://github.com/laits1/test-project2.git"
        CLOUDSDK_CORE_DISABLE_PROMPTS = "1"
        GOOGLE_APPLICATION_CREDENTIALS = "/home/thsehdrl94/test/jenkins-sa.json"
        VM_NAME = "gcloud-my-vm"
        IMAGE_FAMILY = "ubuntu-2004-lts"
        IMAGE_PROJECT = "ubuntu-os-cloud"
        ZONE = "asia-northeast3-a"
        MACHINE_TYPE = "n1-standard-1"
        BOOT_DISK_SIZE = "10GB"
        TAGS = "http-server,https-server"
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
        stage('Create VM') {
            steps {
                sh 'gcloud compute instances create $VM_NAME --image-family=$IMAGE_FAMILY --image-project=$IMAGE_PROJECT --zone=$ZONE --machine-type=$MACHINE_TYPE --boot-disk-size=$BOOT_DISK_SIZE --tags=$TAGS'
            }
        }
  }
}

