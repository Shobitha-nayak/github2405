pipeline {
    agent any

    environment {
        PROJECT_ID = 'github2405'
        CLUSTER_NAME = 'mycluster24'
        CLUSTER_ZONE = 'us-central1'
        DOCKER_IMAGE_TAG = 'v3'
        DOCKER_IMAGE_NAME = "gcr.io/${PROJECT_ID}/gitrepo:${DOCKER_IMAGE_TAG}"
    }

    stages {
        stage('Copy Repository Contents') {
            steps {
                git branch: 'main', url: 'https://github.com/Shobitha-nayak/github2405.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE_NAME} ."
            }
        }

        stage('Push Docker Image to GCR') {
            steps {
                withCredentials([file(credentialsId: 'GCPCredentials', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'cat $GOOGLE_APPLICATION_CREDENTIALS | docker login -u _json_key --password-stdin https://gcr.io'
                    sh "docker push ${DOCKER_IMAGE_NAME}"
                }
            }
        }

        stage('Deploy to GKE') {
            steps {
                withCredentials([file(credentialsId: 'GCPCredentials', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh "gcloud container clusters get-credentials ${CLUSTER_NAME} --zone ${CLUSTER_ZONE} --project ${PROJECT_ID}"
                    sh "kubectl apply -f ."
                }
            }
        }
    }
}
