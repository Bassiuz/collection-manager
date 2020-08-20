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
            steps {
                script {
                    if (env.BRANCH_NAME == 'master') {
                        build job: 'Collection Manager - Build Master to local Docker'
                    }
                }
            }
        }
    }
}