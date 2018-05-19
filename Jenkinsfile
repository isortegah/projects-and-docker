pipeline {
    agent {
        dockerfile { 
            filename 'Dockerfile'
            additionalBuildArgs '-t isortegah/test:v1'
        }
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}