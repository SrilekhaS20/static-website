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
                    // Using wget as an alternative to curl
                    def response = sh(script: "wget -qO- https://hub.docker.com/repository/docker/sri24devops/static-website/${DOCKER_IMAGE_NAME}/tags", returnStdout: true)
                    def json = readJSON(text: response)

                    // Extract tags and find the latest version
                    def tags = json.results*.name
                    def latestTag = tags.find { it.startsWith('v') }?.replaceAll('^v', '') // Remove 'v' for version comparison
                    echo "Latest tag found: ${latestTag}"

                    if (latestTag) {
                        // Increment the version based on the latest tag
                        def newVersion = incrementVersion(latestTag)
                        echo "New version will be: v${newVersion}" // Add 'v' back for the new version
                    } else {
                        echo "No valid tags found, starting from v0.0.1"
                        def newVersion = '0.0.1'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Assuming newVersion is already set from the previous stage
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:v${newVersion} ."

                    // Login to Docker Hub
                    sh "echo ${DOCKER_HUB_CREDENTIALS_PSW} | docker login -u ${DOCKER_HUB_CREDENTIALS_USR} --password-stdin"

                    // Push Docker image
                    sh "docker push ${DOCKER_IMAGE_NAME}:v${newVersion}"
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
