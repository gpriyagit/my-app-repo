pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-app-image'
        DOCKER_TAG = 'latest'
        DOCKER_REGISTRY = 'amulyapriya'
        DOCKER_PORT = 3000
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    sh 'docker build -t $DOCKER_REGISTRY/$DOCKER_IMAGE:$DOCKER_TAG .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-creds', url: 'https://hub.docker.com/repositories/amulyapriya']) {
                    script {
                        docker.image("${DOCKER_HUB_USER}/${IMAGE_NAME}").push('v1')
                    }
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove the existing container if it exists
                    sh 'docker ps -q -f name=my-app-container | xargs -r docker stop | xargs -r docker rm'

                    // Run the new container
                    sh 'docker run -d -p 3000:$DOCKER_PORT --name my-app-container $DOCKER_REGISTRY/$DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }
        
        stage('Cleanup') {
            steps {
                script {
                    // Clean up unused Docker images
                    sh 'docker system prune -f'
                }
            }
        }
    }

    post {
        always {
            // Clean up containers and images after the pipeline runs
            sh 'docker ps -q -f name=my-app-container | xargs -r docker stop | xargs -r docker rm'
        }
    }
}
