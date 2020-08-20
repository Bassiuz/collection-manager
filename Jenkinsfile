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
                        sh '[ "$(docker ps -a | grep collection-manager-master)" ] && docker rm --force collection-manager-master'
                        sh 'docker build --tag collection-manager:1.0 .'
                        sh 'docker run --publish 3000:3000 --detach --name collection-manager-master collection-manager:1.0'
                    }
                }
            }
        }
    }
}