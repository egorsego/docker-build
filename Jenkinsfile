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
                    docker.build(compilerImageTitle + ":latest", "-f ${env.WORKSPACE}/rf_compiler/compiler.dockerfile .")
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
                    docker.build(libraryImageTitle + ":latest", "-f ${env.WORKSPACE}/sf_library/library.dockerfile .")
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
                    docker.build(fiscatImageTitle + ":latest", "-f ${env.WORKSPACE}/fiscat/fiscat.dockerfile .")
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

/*
        stage('Build Units Test Image'){
            steps{
                echo 'Building Units Test image...'
                script {
                    docker.build(unitsTestImageTitle + ":latest", "-f ${env.WORKSPACE}/units/units.dockerfile .")
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
*/

        stage('SSH Test'){
            steps{
                echo 'Testing SSH Connection'

                sh 'touch test_file_2711'
                sh 'scp ./test_file_2711 root@192.168.242.180:/FisGo'
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