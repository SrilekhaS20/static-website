pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker_id')
        GITHUB_REPO = 'https://github.com/SrilekhaS20/static-website.git'
        DOCKER_IMAGE_NAME = 'sri24devops/static-website'
        PORT = '8090'
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
        stage('Run Docker Container Locally') {
            steps {
                script {
                    // Run the Docker container with port forwarding
                    sh "docker run -d -p ${PORT}:80 --name static-site ${DOCKER_IMAGE_NAME}:v${env.NEW_VERSION}"
                    echo "Docker container is running on port ${PORT}"
                }
            }
        }
        stage('Deploy to MInikube') {
            steps {
                script {
                    // Set contect to Minikube
                    sh "kubectl config use-context ${MINIKUBE_CONTEXT}"

                    // Replace TAG in deployment.yaml with new Docker image version
                    sh "sed -i 's|${DOCKER_IMAGE_NAME}:TAG|${DOCKER_IMAGE_NAME}:{env.NEW_VERSION}|g' deployment.yaml"

                    // Apply deployment and service yaml files
                    sh "kubectl apply -f deployment.yaml"
                    sh "kubectl apply -f service.yaml"
                }
            }
        }
        stage('Start Minikube tunnel') {
            steps {
                script {
                    // Expose LOadbalancer services
                    sh "minikube tunnel &"
                    sleep(10)
                }
            }
        }
        stage('Access the site') {
            steps {
                script {
                    // Retrieving external IP of LoadBalancer
                    def externalIP = sh(script: "kubectl get svc static-website -o jsonpath='{.status.loadbalancer.ingress[0].ip}'",returnStdout: true).trim()
                    echo "Accessing the site at:http//${externalIP}:80"
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
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
