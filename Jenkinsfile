pipeline {
    agent any

    environment {
        registry = "henriqy/docker-repo"
        registryCredential = 'docker-hub-credentials'
        dockerImage = ''
    }

    stages {
        stage('Clonar Repositório') {
            steps {
                git 'https://github.com/henriqy/infraestrutura_CI.git'
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
