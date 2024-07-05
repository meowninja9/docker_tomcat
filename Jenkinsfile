pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'java-tomcat-japanese'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amanygamel/docker_tomcat.git', credentialsId: 'your-credentials-id'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove existing container if it exists
                    sh '''
                    if [ $(docker ps -a -q -f name=tomcat) ]; then
                        docker stop tomcat || true
                        docker rm tomcat || true
                    fi
                    '''
                    // Run the new container
                    docker.image("${env.DOCKER_IMAGE}:${env.DOCK
