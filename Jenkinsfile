def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"
def fiscatImageTitle = "dreamkas-fiscat-f"
def unitsTestImageTitle = "dreamkas-units"

pipeline{
    agent any
    stages{
        stage("Checkout"){
            steps{
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_start.sh"
		            sh "${env.WORKSPACE}/ci/bash_scripts/stage_start.sh $TOKEN 'Jenkins-CI: Checkout Stage'"
                }

                echo "Cloning FisGo-F Library repository code..."
                dir("FisGo") {
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/dreamkas/FisGo_F.git", branch: "develop"
                }
            }

            post{
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_success.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_success.sh $TOKEN 'Jenkins-CI: Checkout Stage'"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh $TOKEN 'Jenkins-CI: Checkout Stage'"
                    }
                }
            }
        }
 
        stage("Build"){
            steps{
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_start.sh"
		            sh "${env.WORKSPACE}/ci/bash_scripts/stage_start.sh $TOKEN 'Jenkins-CI: Build Stage'"
                }

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
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_success.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_success.sh $TOKEN 'Jenkins-CI: Build Stage'"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh $TOKEN 'Jenkins-CI: Build Stage'"
                    }
                }
            }
        }

        stage("Test"){
            steps{
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_start.sh"
		            sh "${env.WORKSPACE}/ci/bash_scripts/stage_start.sh $TOKEN 'Jenkins-CI: Test Stage'"
                }

                dir("AutoTests"){
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/egorsego/fisgo_test.git", branch: "master"
                }
                
                echo "Testing..."
            }

            post{
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_success.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_success.sh $TOKEN 'Jenkins-CI: Test Stage'"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh $TOKEN 'Jenkins-CI: Test Stage'"
                    }
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
