pipeline{
    agent any
    stages{
        stage('Build image'){
            steps{
                echo 'Starting to build a docker image'

                script {
                    def dockerImage = docker.build("myImage:myTag")
                }
            }
        }
    }
}