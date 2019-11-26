def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"

pipeline{
    agent any
    stages{
        
        stage('Cloning Repositories'){
            steps{
                echo 'Checking out FisGo-F Library repository code...'
                dir('fisgo') {
                    git credentialsId: 'egorsego-github', url: 'https://github.com/dreamkas/FisGo_F.git'
                }
            }
        }

        stage('Build Compiler Image'){
            steps{
                echo 'Building DreamkasRfCompiler image...'
                script {
                    def dreamkasRfCompilerImage = docker.build(compilerImageTitle + ":latest", "-f ${env.WORKSPACE}/rf_compiler/Dockerfile .")
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
                    def dreamkasSFLibraryImage = docker.build(libraryImageTitle + ":latest", "-f ${env.WORKSPACE}/sf_library/Dockerfile .")
                }
            }
        }
    }

    post{
        always{
            echo 'Cleaning up workspace...' 
            cleanWs()
        }
    }
}