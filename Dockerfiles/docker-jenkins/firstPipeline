pipeline {
   agent none

   stages {
      stage('Run Tests') {
         parallel{
             stage ('Test in bash'){
                 agent{ label 'bash'}
                 steps {
                     echo "Hello World"
                     sleep 10
                 }
             }
             stage('Test in bash2'){
                 agent{ label 'bash2'}
                 steps {
                     echo "Hello World"
                     sleep 10
                     sh '''
                        echo "Multiline shell steps works too"
                        ls -lah
                    '''
                 }
             }
         }
         
      }
      stage('Test') {
       agent{ label 'bash2'}
                 steps {
                     echo "Hello World"
                     sleep 10
                 }   
      }
   }
   post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}