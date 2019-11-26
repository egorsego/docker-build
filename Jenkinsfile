pipeline{
    agent any
    stages{

        stage('Clone Repository'){
            steps{
                echo 'Checking out DreamkasRfCompiler repository code...'
                checkout scm
            }
        }
        stage('Build Image'){
            steps{
                echo 'Building a docker image...'

                script {
                    def dreamkasRfCompilerImage = docker.build("dreamkas_rf_compiler:${env.BUILD_ID}, "-f ${env.WORKSPACE}/rf_compiler/Dockerfile ."")
                }
            }
        }
    }
}