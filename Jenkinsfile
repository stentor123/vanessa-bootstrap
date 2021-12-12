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
            allure includeProperties: false, jdk: '', results: [[path: 'out/syntax-check/allure'], [path: 'out/allure/smoke'], [path: 'out/allure'], [path: 'build/tests/allure'] ]
            junit allowEmptyResults: true, testResults: 'out/syntax-check/junit/junit.xml'
            junit allowEmptyResults: true, testResults: 'out/*.xml' 
            junit allowEmptyResults: true, testResults: 'build/tests/junit/*.xml' 
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
                script{
                    try {
                        bat "chcp 65001\n vrunner syntax-check"
                    } catch(Exception Exc) {
                         currentBuild.result = 'UNSTABLE'
                    }
                }
 
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
                        bat "chcp 65001\n runner run --ibconnection /FC:\\tools\\acc --db-user \"Administrator\" --db-pwd \"\" --ordinaryapp 1 --command \"acc.propertiesPaths=C:\\tools\\MYTEST\\tools\\acc-export\\acc.properties;\" --execute \"C:\\tools\\MYTEST\\tools\\acc-export\\acc-export.epf"
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
                    bat "chcp 65001\n C:\\tools\\sonar-scanner\\bin\\sonar-scanner -D sonar.login=8e062c3498d898706375d7f94397cd48b13b73df -D sonar.projectVersion=${BUILD_ID}"
                }  
            }
        }

    }

    stage("Модульные тесты") {
            steps {
                script{
                    try {
                        bat """chcp 65001
                        call vrunner compileepf tests tests
                        call vrunner xunit --settings ./env-tests.json""""
                    } catch(Exception Exc) {
                         currentBuild.result = 'UNSTABLE'
                    }
                }
 
            }
        }

}
