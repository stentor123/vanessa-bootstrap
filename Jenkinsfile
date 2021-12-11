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
            allure includeProperties: false, jdk: '', results: [[path: 'out/syntax-check/allure'], [path: 'out/allure/smoke'], [path: 'out/allure']]
            junit allowEmptyResults: true, testResults: 'out/syntax-check/junit/junit.xml'
            junit allowEmptyResults: true, testResults: 'out/*.xml' 
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
                bat "chcp 65001\n vrunner init-dev --dt C:\\tools\\MYTEST\\build\\course.dt --db-user Администратор --db-pwd 123 --src C:\\tools\\MYTEST\\src\\cf"
 
            }
        } 

        stage("Синтаксический контроль") {
            steps {
               script {
                    try {
                        bat "chcp 65001\n vrunner syntax-check"

                    } catch(Exception Exc) {
                        currenBuild.result = 'UNSTABLE'
                    }   
               }
 
            }
        }

        stage("Дымовые тесты") {
            steps {
               script {
                    try {
                            bat "chcp 65001\n runner xunit"

                    } catch(Exception Exc) {
                        currenBuild.result = 'UNSTABLE'
                    }   
               }
 
            }
    }    

}
