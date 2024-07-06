pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def image = docker.build("python3-image")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                bat 'docker run -d python3-image'
            }
        }
    }
    post {
        always {
            script {
                if (isUnix()) {
                    sh 'echo "Post build actions on Unix"'
                } else {
                    bat 'echo Post build actions on Windows'
                }
            }
        }
    }
}
