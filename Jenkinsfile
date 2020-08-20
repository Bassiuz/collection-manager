pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                rvm 'bundle exec rspec'
                rvm 'bundle exec cucumber'
            }
        }
    }
}