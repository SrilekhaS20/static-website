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
                git url: GITHUB_REPO, branch: 'main', credentialsId: 'Github_id'
                // Check Git version
                script {
                    def gitVersion = sh(script: 'git --version', returnStdout: true).trim()
                    echo "Git version: ${gitVersion}"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def currentVersion = sh(script: 'git describe --tags --abbrev=0', returnStdout: true).trim()
                    def newVersion = incrementVersion(currentVersion)

                    // Build Docker image
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:${newVersion} ."

                    // Login to Docker Hub
                    sh "echo ${DOCKER_HUB_CREDENTIALS_PSW} | docker login -u ${DOCKER_HUB_CREDENTIALS_USR} --password-stdin"

                    // Push Docker image
                    sh "docker push ${DOCKER_IMAGE_NAME}:${newVersion}"
                }
            }
        }
    }
}

def incrementVersion(String version) {
    // Remove the 'v' prefix if present
    if (version.startsWith("v")) {
        version = version.substring(1)
    }
    
    // Increment the patch version
    def versionParts = version.tokenize('.')
    if (versionParts.size() != 3) {
        error("Invalid version format: ${version}. Expected format: major.minor.patch")
    }
    
    def major = versionParts[0].toInteger()
    def minor = versionParts[1].toInteger()
    def patch = versionParts[2].toInteger() + 1
    return "${major}.${minor}.${patch}"
}
