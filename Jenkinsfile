def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"

pipeline{
    agent any
    stages{
        
        stage('Cloning Repositories'){
            steps{
                echo 'Checking out FisGo-F Library repository code...'
                dir('FisGo') {
                    git credentialsId: 'fisgo-ci-github', url: 'https://github.com/dreamkas/FisGo_F.git', branch: 'develop'
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
                    sh 'docker container prune --force'
                    sh 'docker image prune --filter "dangling=true" --force'
                }
            }
        }

        stage('Build Library Image'){
            steps{
                echo 'Removing old Library image...'
                sh "docker rmi ${libraryImageTitle}:latest || true" 

                echo 'Building DreamkasSFLibrary image...'
                script {
                    def dreamkasSFLibraryImage = docker.build(libraryImageTitle + ":latest", "-f ${env.WORKSPACE}/sf_library/Dockerfile .")
                }

                sh 'mkdir -p ./PATCH/lib'
                sh 'find . -name *.so -exec cp -- "{}" ./PATCH/lib/'
            }

            post{
                always{
                    echo 'Removing dangling images...' 
                    sh 'docker container prune --force'
                    sh 'docker image prune --filter "dangling=true" --force'
                }
            }
        }
    }
}