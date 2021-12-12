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
                bat "chcp 65001\n vrunner syntax-check"
 
            }
        }


    stage("Дымовые тесты") {
            steps {
                script{
                    try {
                        bat "chcp 65001\n runner xunit"
                    } catch(Exception Exc) {
                         currentBuild.result = 'UNSTABLE'
                    }
                }
 
            }
        }

    stage("vanessa") {
            steps {
                script{
                    try {
                        bat "chcp 65001\n runner vanessa"
                    } catch(Exception Exc) {
                         currentBuild.result = 'UNSTABLE'
                    }
                }
 
            }
        }

    stage("АПК") {
            steps {
                script{
                    try {
                        bat "chcp 65001\n runner run --ibconnection /FC:\\tools\\ACC\\ --db-user \"Администратор\" --db-pwd \"\"  --command \"acc.catalog=${WORKSPACE};acc.propertiesPaths=./tools/acc-export/acc.properties;\" --execute \"./tools/acc-export/acc-export.epf\" --ordinaryapp=1"
                    } catch(Exception Exc) {
                         currentBuild.result = 'UNSTABLE'
                    }
                }
 
            }
        }

    stage("Sonar") {
            steps {
                script{
                       scannerHome = tool 'sonar-scanner'
                }
            withSonarQubeEnv ("sonar") {
                    bat "${scannerHome}/bin/sonar-scanner -D sonar.login=8e062c3498d898706375d7f94397cd48b13b73df -D sonar.projectVersion=${BUILD_ID}"
                }  
            }
        }

    }
}
