pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh "ls"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Build Image') {
            steps {
                sh "docker rm --force collection-manager"
                sh "docker build --tag collection-manager:1.0 ."
            }
        }
        stage('Deploy') {
            steps {
                sh "docker run --publish 3000:3000 --detach --name collection-manager collection-manager:1.0 "
            }
        }
    }
}