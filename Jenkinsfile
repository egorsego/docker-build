pipeline{
    agent{
        dockerfile{
            filename 'Dockerfile'
            args '-t fisgo-name'
            additionalBuildArgs  '--force-rm'
        }
    }
    stages{
        stage('Create an image out of Dockerfile'){
            steps{
                echo 'building an image...'
            }
        }
    }
}