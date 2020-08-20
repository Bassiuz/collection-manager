pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                sh "bundle exec rspec"
                sh "bundle exec cucumber"
            }
        }
        stage('Publish') {
            steps {
                def customImage = docker.build("collection-manager:${env.BUILD_ID}")
                customImage.push()
            }
        }
    }
}