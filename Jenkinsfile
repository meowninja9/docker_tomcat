pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'python3-image'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository containing the Dockerfile
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    def dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh 'docker run -d --name python3-container ${DOCKER_IMAGE}'
                }
            }
        }
    }

    post {
        always {
            // Clean up
            sh 'docker rm -f python3-container || true'
            sh 'docker rmi ${DOCKER_IMAGE} || true'
        }
    }
}
