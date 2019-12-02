def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"
def fiscatImageTitle = "dreamkas-fiscat-f"
def unitsTestImageTitle = "dreamkas-units"

pipeline{
    agent any
    stages{

        stage("Workspace Cleanup"){
            steps{
                script{
                    if("${IS_WORKSPACE_CLEANING_NEEDED}" == "Yes"){
                        echo "Cleaning up workspace..." 
                        cleanWs()
                    }
                }
            }
        }
        
        stage("Checkout"){
            steps{

                echo "Cloning FisGo-CI repository code..."
                dir("ci") {
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/egorsego/docker-build.git", branch: "master"
                }

                echo "Cloning FisGo-F Library repository code..."
                dir("FisGo") {
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/dreamkas/FisGo_F.git", branch: "develop"
                }
            }
        }
 
        stage("Build Compiler Image"){
            steps{
                echo 'Removing old Compiler image...'
                sh "docker rmi ${compilerImageTitle}:latest || true"

                echo "Building DreamkasRfCompiler image..."
                script {
                    docker.build(compilerImageTitle + ":latest", "-f ${env.WORKSPACE}/ci/rf_compiler/compiler.dockerfile .")
                }
            }

            post{
                always{
                    removeUnusedContainersAndDanglingImages()
                }
            }
        }

        stage("Build Library Image"){
            steps{
                echo "Removing old Library image..."
                sh "docker rmi ${libraryImageTitle}:latest || true" 

                echo "Building DreamkasSFLibrary image..."
                script {
                    docker.build(libraryImageTitle + ":latest", "-f ${env.WORKSPACE}/ci/sf_library/library.dockerfile .")
                }

                echo "Examining files after compilation..."
                sh "docker run --name libraryContainer ${libraryImageTitle}:latest ls -la /tmp/FisGo"

                echo "Copying files from image..."
                sh "docker cp libraryContainer:/tmp/FisGo/PATCH/lib ./FisGo/PATCH"
                //sh "find ./FisGo/tmp -type f -name '*.so' -exec cp '{}' ./FisGo/PATCH/lib/ ';'"
                //sh "rm -r ./FisGo/tmp"
            }

            post{
                success{
                    echo "Archiving artifacts..."
                    //archiveArtifacts artifacts: "**/FisGo/PATCH/lib/**/*"
                }
                always{
                    removeUnusedContainersAndDanglingImages()
                }
            }
        }
 
        stage("Build Fiscat Image"){
            steps{
                echo "Building Fiscat image..."
                script {
                    docker.build(fiscatImageTitle + ":latest", "-f ${env.WORKSPACE}/ci/fiscat/fiscat.dockerfile .")
                }

                echo "Examining files after compilation..."
                sh "docker run --name fiscatContainer ${fiscatImageTitle}:latest ls -la /tmp/FisGo/build"

                echo "Copying files from image..."
                sh "mkdir -p ./FisGo/build/fiscat"
                sh "docker cp fiscatContainer:/tmp/FisGo/build/fiscat ./FisGo/build/fiscat"
            }

            post{
                success{
                    echo "Archiving artifacts..."
                    //archiveArtifacts artifacts: "**/FisGo/build/fiscat/*"
                }
                always{
                    removeUnusedContainersAndDanglingImages()
                }
            }
        }
/* 
        stage("Build Units Test Image"){
            steps{
                echo "Building Units Test image..."
                script {
                    docker.build(unitsTestImageTitle + ":latest", "-f ${env.WORKSPACE}/ci/units/units.dockerfile .")
                }

                echo "Examining files after compilation..."
                sh "docker run --name unitsContainer ${unitsTestImageTitle}:latest ls -la /tmp/FisGo/build"

                echo "Copying files from image..."
                sh "mkdir -p ./FisGo/build/units"
                sh "docker cp unitsContainer:/tmp/FisGo/build/units ./FisGo/build/units"
            }

            post{
                success{
                    echo "Archiving artifacts..."
                    //archiveArtifacts artifacts: "/FisGo/build/units/*"
                }
                always{
                    removeUnusedContainersAndDanglingImages()
                }
            }
        }

        stage("SSH Test"){
            steps{
                echo "Testing SSH Connection"
                //sh "scp ./test_file_2811 root@192.168.242.180:/FisGo"
                //sh "ssh -T root@192.168.242.180 < ${env.WORKSPACE}/ci/bash_scripts/test_script.sh"
            }
        }
*/
        stage("Test"){
            steps{
                dir("AutoTests"){
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/egorsego/fisgo_test.git", branch: "master"
                }
                sh '''
                    cd ./AutoTests
                    mvn clean test -Dsurefire.suiteXmlFiles=src/test/resources/dkf.xml
                '''
            }

            post{
                always{
                    allure includeProperties: false, jdk: '', results: [[path: '**/target/allure-results']]
                }
            }
        }
    }
}

void removeUnusedContainersAndDanglingImages() {
    echo "Removing dangling images..." 
    sh "docker container prune --force"
    sh "docker image prune --filter 'dangling=true' --force"
}