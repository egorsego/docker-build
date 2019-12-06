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
		            sh "${env.WORKSPACE}/ci/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
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
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }
 
        stage("Build"){          
            steps{
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_start.sh"
		            sh "${env.WORKSPACE}/ci/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
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
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }

        stage("Test"){          
            steps{
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_start.sh"
		            sh "${env.WORKSPACE}/ci/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
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
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
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
