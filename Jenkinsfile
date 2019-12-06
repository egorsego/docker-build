def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"
def fiscatImageTitle = "dreamkas-fiscat-f"
def unitsTestImageTitle = "dreamkas-units"

pipeline{
    agent any
    stages{
        stage("Checkout"){
            def stageName = "Jenkins-CI: Checkout Stage"
            
            steps{
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_start.sh"
		            sh "${env.WORKSPACE}/ci/bash_scripts/stage_start.sh $TOKEN ${stageName}"
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
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_success.sh $TOKEN ${stageName}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh $TOKEN ${stageName}"
                    }
                }
            }
        }
 
        stage("Build"){
            def stageName = "Jenkins-CI: Build Stage"
            
            steps{
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_start.sh"
		            sh "${env.WORKSPACE}/ci/bash_scripts/stage_start.sh $TOKEN ${stageName}"
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
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_success.sh $TOKEN ${stageName}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh $TOKEN ${stageName}"
                    }
                }
            }
        }

        stage("Test"){
            def stageName = "Jenkins-CI: Test Stage"
            
            steps{
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_start.sh"
		            sh "${env.WORKSPACE}/ci/bash_scripts/stage_start.sh $TOKEN ${stageName}"
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
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_success.sh $TOKEN ${stageName}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "chmod +x ${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh"
		                sh "${env.WORKSPACE}/ci/bash_scripts/stage_failure.sh $TOKEN ${stageName}"
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
