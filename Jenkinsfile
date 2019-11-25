pipeline{
    agent any
    stages{

        stage('Checkout'){
            steps{
                echo 'Checking out DreamkasRfCompiler repository code...'
                checkout scm
            }
        }
        stage('Build image'){
            steps{
                echo 'Building a docker image...'
                
                script {
                    def dockerImage = docker.build("my_image:my_tag")
                }
            }
        }
    }
}