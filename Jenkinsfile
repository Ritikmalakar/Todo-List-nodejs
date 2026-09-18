pipeline {
    agent {
        label 'node-agent'
    }

    stages {

        stage('Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Ritikmalakar/Todo-List-nodejs.git'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t ritikmalakar/node-todo-cicd:latest .'
            }
        }

        stage('Push') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerHub',
                        usernameVariable: 'dockerHubUser',
                        passwordVariable: 'dockerHubPassword'
                    )
                ]) {
                    sh '''
                        echo "$dockerHubPassword" | docker login -u "$dockerHubUser" --password-stdin
                        docker push ritikmalakar/node-todo-cicd:latest
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                sh 'docker image inspect ritikmalakar/node-todo-cicd:latest'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker compose up -d'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}