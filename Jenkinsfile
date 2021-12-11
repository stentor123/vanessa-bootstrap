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
                bat "chcp 65001\n vrunner init-dev --dt C:\\tools\\MYTEST\\build\\course.dt --db-user Администратор --db-pwd 123 --src C:\\tools\\J\\src\\cf"
 
            }
        }
        
        stage("Синтаксический контроль") {
            steps {
                bat "vrunner syntax-check"
 
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
