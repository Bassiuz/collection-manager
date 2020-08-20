pipeline {
    agent { dockerfile true }
    environment {
        registry = "bassiuz/collection-manager"
        registryCredential = 'dockerhub'
    }
    stages {
        stage('Test') {
            steps {
                sh "bundle exec rspec"
                sh "bundle exec cucumber"
            }
        }
        stage('Trigger new job') {
           build job: 'test-with-bash'
        }
    }
}