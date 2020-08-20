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
            if (env.BRANCH_NAME == 'docker') {
                build job: 'test-with-bash'
            }
        }
    }
}