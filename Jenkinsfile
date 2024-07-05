pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'java-tomcat-japanese'
        DOCKER_TAG = 'latest'
        DOCKER_REGISTRY_URL = 'https://index.docker.io/v1/'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amanygamel/docker_tomcat.git', credentialsId: '516cd9f0-172e-4b4e-9056-f7197ade3658'
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    docker.withRegistry("${env.DOCKER_REGISTRY_URL}", 'docker-hub-credentials') {
                        echo 'Logged in to Docker Hub'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def app = docker.build("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}")
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
                    docker.image("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}").run('-d -p 8080:8080 --name tomcat')
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker ps -a'
            }
        }
        cleanup {
            cleanWs()
        }
    }
}
