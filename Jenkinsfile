pipeline {
    agent any

    environment {
        // GCP 서비스 계정 인증 정보를 설정합니다.
        GOOGLE_APPLICATION_CREDENTIALS = credentials('jenkins-sa.json') // Jenkins의 "Secret file" credentials 타입으로 미리 업로드된 GCP 서비스 계정 키 파일
    }

    stages {
        stage('Create VM') {
            steps {
                script {
                    // GCP 인증 정보 설정
                    withCredentials([file(credentialsId: 'gcp-service-account-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        // GCP 프로젝트 ID
                        def projectId = 'test-project2-394700'
                        // GCP 지역 (예: 'us-central1', 'europe-west1' 등)
                        def region = 'asia-northeast3'
                        // GCP 인스턴스 이름
                        def instanceName = 'gcloud-vm'
                        // GCP 인스턴스 타입 (예: 'n1-standard-1', 'f1-micro' 등)
                        def instanceType = 'e2-medium'

                        // gcloud 명령어를 사용하여 VM 인스턴스 생성
                        sh """
                            gcloud auth activate-service-account --key-file=\$GOOGLE_APPLICATION_CREDENTIALS
                            gcloud config set project ${projectId}
                            gcloud compute instances create ${instanceName} \
                                --zone=${region} \
                                --machine-type=${instanceType} \
                        """
                    }
                }
            }
        }
    }
}

