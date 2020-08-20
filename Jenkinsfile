pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                bundle exec rspec
                bundle exec cucumber
            }
        }
    }
}