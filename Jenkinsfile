pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // Remplacez par l'ID de vos credentials Docker Hub dans Jenkins
        DOCKER_IMAGE = "eline2016/examen-devops:latest"         // Remplacez par votre nom d'utilisateur Docker Hub 
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/imenH-cloud/examen-devops' // Remplacez par votre repo
            }
        }

        stage('Build Application') {
            steps {
                echo 'Building the Spring Boot application...'
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: '']) {
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }

        stage('Clean Workspace') {
            steps {
                echo 'Cleaning up workspace...'
                cleanWs()
            }
        }
    }

    triggers {
        pollSCM('H/5 * * * *') // Vérifie les changements dans le dépôt toutes les 5 minutes
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for more details.'
        }
    }
}
