pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'java-tomcat-japanese'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amanygamel/docker_tomcat.git', credentialsId: '90406132-0908-4605-81c0-dc78b1657819'
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
            bat '''
            if (docker ps -a -q -f name=tomcat) {
                docker stop tomcat || true
                docker rm tomcat || true
            }
            '''
            // Run the new container
            docker.image("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}").run('-d -p 8080:8080 --name tomcat')
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
