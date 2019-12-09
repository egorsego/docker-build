def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"
def fiscatImageTitle = "dreamkas-fiscat-f"
def unitsTestImageTitle = "dreamkas-units"
def cashboxIP = "192.168.242.180"

pipeline{
    agent any
    stages{
        stage("Checkout"){
            steps{
                echo "Cloning FisGo_CI repository code..."
                dir("CI") {
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/dreamkas/FisGo_CI.git", branch: "master"
                }

                sh "chmod +x ${env.WORKSPACE}/CI/bash_scripts/stage_start.sh"
                sh "chmod +x ${env.WORKSPACE}/CI/bash_scripts/stage_success.sh"
                sh "chmod +x ${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh"
            }
            post{
                always{
		            withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                        sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }
 
        stage("Build_Compiler_Image"){
            steps{
                echo "Building compiler image..."
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
                }
                //script{
                    //docker.build(compilerImageTitle + ":latest", "-f ${env.WORKSPACE}/CI/rf_compiler/compiler.dockerfile .")
                //}
            }
            post{
                always{
                    removeUnusedContainersAndDanglingImages()
                }
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }

        stage("Deploy_Libraries"){
            steps{
                echo "Deploying libraries..."
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
                }
                //script{
                    //docker.build(libraryImageTitle + ":latest", "-f ${env.WORKSPACE}/CI/sf_library/library.dockerfile .")
                //}
                
                //sh "docker create --name libraryContainer ${libraryImageTitle}:latest"
                //sh "docker cp libraryContainer:/tmp/FisGo/PATCH/lib ./FisGo/PATCH"
            }
            post{
                always{
                    removeUnusedContainersAndDanglingImages()
                }
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }

        stage("Compile_Fiscat"){
            steps{
                echo "Compiling fiscat..."
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
                }
                //script{
                    //docker.build(fiscatImageTitle + ":latest", "-f ${env.WORKSPACE}/CI/fiscat/fiscat.dockerfile .")
                //}
                
                //sh "docker create --name fiscatContainer ${fiscatImageTitle}:latest"
                //sh "docker cp fiscatContainer:/tmp/FisGo/build/fiscat ./FisGo/PATCH/FisGo"
            }
            post{
                always{
                    removeUnusedContainersAndDanglingImages()
                }
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }

        stage("Compile_Unit_Tests"){
            steps{
                echo "Compiling unit tests..."
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
                }
                //script{
                    //docker.build(unitsTestImageTitle + ":latest", "-f ${env.WORKSPACE}/CI/units/units.dockerfile .")
                //}
                
                //sh "docker create --name unitsContainer ${unitsTestImageTitle}:latest"
                //sh "docker cp unitsContainer:/tmp/FisGo/build/units ./FisGo/PATCH/FisGo"
            }
            post{
                always{
                    removeUnusedContainersAndDanglingImages()
                }
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }

        stage("Patch_Cashbox"){
            steps{
                echo "Patching cashbox..."
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
                }
                /*
                sh '''
                    cd ./FisGo/PATCH/
                    find . -type f -not -path "*etc/init.*" > ../deleteList
                '''
                sh "scp ./FisGo/deleteList root@${cashboxIP}:/"
                sh "ssh -T root@${cashboxIP} < ${env.WORKSPACE}/CI/bash_scripts/shutdown_fiscat.sh"
                sh "ssh -T root@${cashboxIP} < ${env.WORKSPACE}/CI/bash_scripts/delete_files.sh"
                sh "scp -r ./FisGo/PATCH/. root@${cashboxIP}:/"
                sh "ssh -T root@${cashboxIP} < ${env.WORKSPACE}/CI/bash_scripts/apply_permissions.sh"
                sh "ssh -T root@${cashboxIP} < ${env.WORKSPACE}/CI/bash_scripts/restart_fiscat.sh"
                sh "ssh -T root@${cashboxIP} < ${env.WORKSPACE}/CI/bash_scripts/remove_deletelist.sh"
                */
            }
            post{
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }

        stage("Run_Unit_Tests"){
            steps{
                echo "Running unit tests..."
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
                }
                //sh "ssh -T root@${cashboxIP} < ${env.WORKSPACE}/CI/bash_scripts/run_unit_tests.sh"
            }
            post{
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }

        stage("Run_System_Tests"){
            steps{
                echo "Running system tests..."
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
                }

                dir("AutoTests"){
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/dreamkas/FisGoTests.git", branch: "master"
                }          
                sh '''
                    cd ./AutoTests
                    mvn clean test -Dsurefire.suiteXmlFiles=src/test/resources/dkf_test.xml
                '''
            }
            post{
                always{
                    allure includeProperties: false, jdk: '', results: [[path: '**/target/allure-results']]
                }
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
            }
        }

        stage("Deploy_DirPatch"){
            steps{
                echo "Deploying dirpatch..."
                withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
                }
            }
            post{
                success{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
                    }
                }
                failure{
                    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	                    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
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

void informGitOnStageStart() {
    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {  
        sh "${env.WORKSPACE}/CI/bash_scripts/stage_start.sh $TOKEN ${env.STAGE_NAME}"
    }
}

void informGitOnStageSuccess() {
    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	    sh "${env.WORKSPACE}/CI/bash_scripts/stage_success.sh $TOKEN ${env.STAGE_NAME}"
    }
}

void informGitOnStageFailure() {
    withCredentials([string(credentialsId: 'pr_builder_plugin', variable: 'TOKEN')]) {
	    sh "${env.WORKSPACE}/CI/bash_scripts/stage_failure.sh $TOKEN ${env.STAGE_NAME}"
    }
}