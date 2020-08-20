pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                sh "bundle exec rspec"
                sh "bundle exec cucumber"
            }
        }
    }
}