pipeline
{
    agent {
        label 'OneS'
    }
    
    environment {
        envString = 'true'
    }
 
    post {
        always {
            bat "echo always"
        }
    
        failure {
            bat "echo failure"
        }
        
        success {
            bat "echo success"      
        }
    }
    stages {
        stage("Создание тестовой базы") {
            steps {
                bat "echo success"
 
            }
        }


    stage("Sonar") {
            steps {
                script{
                       scannerHome = tool 'sonar-scanner'
                }
            }
        }

    }
}
