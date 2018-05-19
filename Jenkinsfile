pipeline {
    agent {
        dockerfile { 
            filename 'Dockerfile'
            dir 'build'
            label 'v1'
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