pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'java-tomcat-japanese'
        DOCKER_TAG = 'latest'
        DOCKER_REGISTRY_URL = 'https://index.docker.io'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/meowninja9/docker_tomcat.git', credentialsId: 'e2563d2e-4f7c-4810-8e50-67d179c07ded'
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
                sh 'docker images'
            }
        }
        cleanup {
            cleanWs()
        }
    }
}
