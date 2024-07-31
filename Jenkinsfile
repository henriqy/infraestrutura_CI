pipeline {
    agent any

    environment {
        registry = "seu-usuario/docker-repo"
        registryCredential = 'docker-hub-credentials'
        dockerImage = ''
    }

    stages {
        stage('Clonar Repositório') {
            steps {
                git 'https://github.com/seu-usuario/seu-repositorio.git'
            }
        }

        stage('Construir Imagem Docker') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
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
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
