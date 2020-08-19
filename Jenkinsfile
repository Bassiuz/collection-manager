pipeline {
    agent { dockerfile true }
    stages {
        stage('Initialize'){
            def dockerHome = tool 'myDocker'
            env.PATH = "${dockerHome}/bin:${env.PATH}"
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
    }
}