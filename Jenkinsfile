def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"
def fiscatImageTitle = "dreamkas-fiscat-f"
def unitsTestImageTitle = "dreamkas-units"

pipeline{
    agent any
    stages{
      
        stage("Checkout"){
            steps{
                echo "${env.GIT_COMMIT}"

                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
                    sh "${env.WORKSPACE}/ci/bash_scripts/checkout_stage_start.sh $TOKEN"
                }

                echo "Cloning FisGo-F Library repository code..."
                dir("FisGo") {
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/dreamkas/FisGo_F.git", branch: "develop"
                }
            }

            post{
                success{
                    sh '''
                        curl "https://api.GitHub.com/repos/egorsego/docker-build/statuses/${env.GIT_COMMIT}?access_token=3bf32d587b844411493edee30f31122fd6c1ded6" \
                        -H "Content-Type: application/json" \
                        -X POST \
                        -d "{\"state\": \"success\", \"context\": \"continuous-integration/jenkins\", \"description\": \"Jenkins-CI: Checkout Stage Completed Successfully\", \"target_url\": \"192.168.242.43/job/pr_test/${env.BUILD_NUMBER}/console\"}"
                    '''
                }
                failure{
                    sh '''
                        curl "https://api.GitHub.com/repos/egorsego/docker-build/statuses/${env.GIT_COMMIT}?access_token=3bf32d587b844411493edee30f31122fd6c1ded6" \
                        -H "Content-Type: application/json" \
                        -X POST \
                        -d "{\"state\": \"failure\", \"context\": \"continuous-integration/jenkins\", \"description\": \"Jenkins-CI: Checkout Stage Failed\", \"target_url\": \"192.168.242.43/job/pr_test/${env.BUILD_NUMBER}/console\"}"
                    '''
                }
            }
        }
 
        stage("Build"){
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
                success{
                    echo "Actions on success"
                }
                failure{
                    echo "Actions on failure"
                }
            }
        }

        stage("Test"){
            steps{
                dir("AutoTests"){
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/egorsego/fisgo_test.git", branch: "master"
                }
                
                echo "Testing..."
            }

            post{
                success{
                    echo "Actions on success"
                }
                failure{
                    echo "Actions on failure"
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