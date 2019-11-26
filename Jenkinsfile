def compilerImageTitle = "dreamkasRfCompiler"
def libraryImageTitle = "dreamkasSfLibrary"

pipeline{
    agent any
    stages{
        
        stage('Clone Repository'){
            steps{
                echo 'Checking out DreamkasRfCompiler repository code...'
                checkout scm
            }
        }

        stage('Build Compiler Image'){
            steps{
                echo 'Building DreamkasRfCompiler image...'
                script {
                    def dreamkasRfCompilerImage = docker.build(compilerImageTitle + ":${env.BUILD_ID}", "-f ${env.WORKSPACE}/rf_compiler/Dockerfile .")
                }
            }

            post{
                always{
                    echo 'Removing dangling images...' 
                    sh 'docker image prune --filter "dangling=true" --force'
                }
            }
        }

        stage('Build Library Image'){
            steps{
                echo 'Removing old Library image...'
                sh "docker rmi ${libraryImageTitle} || true" 

                echo 'Building DreamkasSFLibrary image...'
                script {
                    def dreamkasSFLibraryImage = docker.build(libraryImageTitle + ":${env.BUILD_ID}", "-f ${env.WORKSPACE}/sf_library/Dockerfile .")
                }
            }
        }
    }
}