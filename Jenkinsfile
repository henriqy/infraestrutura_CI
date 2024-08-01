pipeline {
    agent any

    environment {
        registry = "henriqy/infraestrutura_ci"
        registryCredential = 'docker-hub-credentials'
        dockerImage = ''
    }

    stages {
        stage('Clonar Repositório') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/henriqy/infraestrutura_CI.git', branch: 'main'
            }
        }

        stage('Construir Imagem Docker') {
            steps {
                script {
                    dockerImage = docker.build("${registry}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Testar no Container Docker') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'pytest tests/'
                    }
                }
            }
        }

        stage('Publicar Imagem') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Limpar') {
            steps {
                sh "docker rmi ${registry}:${env.BUILD_NUMBER}"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
