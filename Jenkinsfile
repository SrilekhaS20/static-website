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
                script {
                    // Check Git version
                    def gitVersion = sh(script: 'git --version', returnStdout: true).trim()
                    echo "Git version: ${gitVersion}"
                }
            }
        }
        stage('Get Latest Docker Image Tag') {
            steps {
                script {
                    // Fetch the latest tags from Docker Hub
                    def response = sh(script: "wget -qO- https://hub.docker.com/v2/repositories/${DOCKER_IMAGE_NAME}/tags", returnStdout: true)
                    def json = readJSON(text: response)

                    // Extract tags and find the latest version
                    def tags = json.results*.name
                    def latestTag = tags.find { it.startsWith('v') }?.replaceAll('^v', '') // Remove 'v' for version comparison
                    echo "Latest tag found: ${latestTag}"

                    // Increment the version based on the latest tag
                    env.NEW_VERSION = latestTag ? incrementVersion(latestTag) : '0.0.1' // Store in environment variable
                    echo "New version will be: v${env.NEW_VERSION}" 
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Check if NEW_VERSION is set
                    if (!env.NEW_VERSION) {
                        error("NEW_VERSION is not defined. Aborting build.")
                    }

                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:v${env.NEW_VERSION} ."

                    // Login to Docker Hub
                    sh "echo ${DOCKER_HUB_CREDENTIALS_PSW} | docker login -u ${DOCKER_HUB_CREDENTIALS_USR} --password-stdin"

                    // Push Docker image
                    sh "docker push ${DOCKER_IMAGE_NAME}:v${env.NEW_VERSION}"
                }
            }
        }
    }
}

def incrementVersion(String version) {
    // Remove 'v' prefix for processing
    def isVPrefix = version.startsWith('v')
    if (isVPrefix) {
        version = version.substring(1)
    }

    // Increment the patch version
    def versionParts = version.tokenize('.')
    def major = versionParts[0].toInteger()
    def minor = versionParts[1].toInteger()
    def patch = versionParts[2].toInteger() + 1

    // Construct new version with 'v' prefix if it was present
    return "${isVPrefix ? 'v' : ''}${major}.${minor}.${patch}"
}
