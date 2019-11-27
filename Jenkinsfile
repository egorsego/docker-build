def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"
def fiscatImageTitle = "dreamkas-fiscat-f"

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

                sh 'mkdir -p ./FisGo/PATCH/lib'
                sh "find . -type f -name '*.so' -exec cp '{}' ./FisGo/PATCH/lib/ ';'"
            }

            post{
                always{
                    echo 'Removing dangling images...' 
                    sh 'docker container prune --force'
                    sh 'docker image prune --filter "dangling=true" --force'
                }
            }
        }

        stage('Build Fiscat Image'){
            steps{
                echo 'Building Fiscat image...'
                script {
                    def dreamkasFiscatImage = docker.build(fiscatImageTitle + ":latest", "-f ${env.WORKSPACE}/fiscat/Dockerfile .")
                }

                echo 'Examining files after compilation...'
                sh "docker run --name fiscatContainer ${fiscatImageTitle}:latest ls -la /tmp/FisGo/build"

                echo 'Copying files from image...'
                sh 'mkdir -p ./FisGo/build/fiscat'
                sh "docker cp ${fiscatImageTitle}:latest:/tmp/FisGo/build/fiscat ./FisGo/build/fiscat"
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
    
    post{
        always{
            echo 'Cleaning up workspace...' 
            cleanWs()
        }
    }
}