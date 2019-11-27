def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"
def fiscatImageTitle = "dreamkas-fiscat-f"
def unitsTestImageTitle = "dreamkas-units"

pipeline{
    agent any
    stages{
        
        stage('Clone FisGo_F Repository'){
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
                    def dreamkasRfCompilerImage = docker.build(compilerImageTitle + ":latest", "-f ${env.WORKSPACE}/rf_compiler/compiler.dockerfile .")
                }
            }

            post{
                always{
                    removeUnusedContainersAndDanglingImages()
                }
            }
        }

        stage('Build Library Image'){
            steps{
                echo 'Removing old Library image...'
                sh "docker rmi ${libraryImageTitle}:latest || true" 

                echo 'Building DreamkasSFLibrary image...'
                script {
                    def dreamkasSFLibraryImage = docker.build(libraryImageTitle + ":latest", "-f ${env.WORKSPACE}/sf_library/library.dockerfile .")
                }

                sh 'mkdir -p ./FisGo/PATCH/lib'
                sh "find . -type f -name '*.so' -exec cp '{}' ./FisGo/PATCH/lib/ ';'"
            }

            post{
                always{
                    removeUnusedContainersAndDanglingImages()
                }
            }
        }

        stage('Build Fiscat Image'){
            steps{
                echo 'Building Fiscat image...'
                script {
                    def dreamkasFiscatImage = docker.build(fiscatImageTitle + ":latest", "-f ${env.WORKSPACE}/fiscat/fiscat.dockerfile .")
                }

                echo 'Examining files after compilation...'
                sh "docker run --name fiscatContainer ${fiscatImageTitle}:latest ls -la /tmp/FisGo/build"

                echo 'Copying files from image...'
                sh 'mkdir -p ./FisGo/build/fiscat'
                sh "docker cp fiscatContainer:/tmp/FisGo/build/fiscat ./FisGo/build/fiscat"
            }

            post{
                always{
                    removeUnusedContainersAndDanglingImages()
                }
            }
        }

        stage('Build Units Test Image'){
            steps{
                echo 'Building Units Test image...'
                script {
                    def unitsTestImage = docker.build(unitsTestImageTitle + ":latest", "-f ${env.WORKSPACE}/units/units.dockerfile .")
                }

                echo 'Examining files after compilation...'
                sh "docker run --name unitsContainer ${unitsTestImageTitle}:latest ls -la /tmp/FisGo/build"

                echo 'Copying files from image...'
                sh 'mkdir -p ./FisGo/build/fiscat/units'
                sh "docker cp unitsContainer:/tmp/FisGo/build/fiscat ./FisGo/build/fiscat/units"
            }

            post{
                always{
                    removeUnusedContainersAndDanglingImages()
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

void removeUnusedContainersAndDanglingImages() {
    echo 'Removing dangling images...' 
    sh 'docker container prune --force'
    sh 'docker image prune --filter "dangling=true" --force'
}