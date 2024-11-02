pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker_id')
        GITHUB_REPO = 'https://github.com/SrilekhaS20/static-website.git'
        DOCKER_IMAGE_NAME = 'sri24devops/static-website'
        MINIKUBE_CONTEXT = 'minikube'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: GITHUB_REPO, branch: 'main'
            }
        }
    }
}
