def compilerImageTitle = "dreamkas-rf-compiler"
def libraryImageTitle = "dreamkas-sf-library"
def fiscatImageTitle = "dreamkas-fiscat-f"
def unitsTestImageTitle = "dreamkas-units"
def cashboxIP = "192.168.242.180"
def fisgoVersion = "Text"


pipeline{
    agent any
    options {
        checkoutToSubdirectory("FisGo")
    }
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
                sh "echo ${fisgoVersion}"
            }
            post{
                always{
		            informGitOnStageStart()
                }
                success{
                    informGitOnStageSuccess()
                }
                failure{
                    informGitOnStageFailure()
                }
            }
        }
 
        stage("Build_Compiler_Image"){
            steps{
                echo "Building compiler image..."
                informGitOnStageStart()
                script{
                    fisgoVersion = "Another text"
                }

                sh "echo ${fisgoVersion}"
                //script{
                    //docker.build(compilerImageTitle + ":latest", "-f ${env.WORKSPACE}/CI/rf_compiler/compiler.dockerfile .")
                //}
            }
            post{
                always{
                    removeUnusedContainersAndDanglingImages()
                }
                success{
                    informGitOnStageSuccess()
                }
                failure{
                    informGitOnStageFailure()
                }
            }
        }

        stage("Deploy_Libraries"){
            steps{
                echo "Deploying libraries..."
                informGitOnStageStart()
                sh "echo ${fisgoVersion}"
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
                    informGitOnStageSuccess()
                }
                failure{
                    informGitOnStageFailure()
                }
            }
        }

        stage("Compile_Fiscat"){
            steps{
                echo "Compiling fiscat..."
                informGitOnStageStart()
                script{
                    fisgoVersion = setFisgoVersion()
                }
                sh "echo ${fisgoVersion}"
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
                    informGitOnStageSuccess()
                }
                failure{
                    informGitOnStageFailure()
                }
            }
        }

        stage("Compile_Unit_Tests"){
            steps{
                echo "Compiling unit tests..."
                informGitOnStageStart()
                sh "echo ${fisgoVersion}"
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
                    informGitOnStageSuccess()
                }
                failure{
                    informGitOnStageFailure()
                }
            }
        }

        stage("Patch_Cashbox"){
            steps{
                echo "Patching cashbox..."
                informGitOnStageStart()
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
                    informGitOnStageSuccess()
                }
                failure{
                    informGitOnStageFailure()
                }
            }
        }

        stage("Run_Unit_Tests"){
            steps{
                echo "Running unit tests..."
                informGitOnStageStart()
                //sh "ssh -T root@${cashboxIP} < ${env.WORKSPACE}/CI/bash_scripts/run_unit_tests.sh"
            }
            post{
                success{
                    informGitOnStageSuccess()
                }
                failure{
                    informGitOnStageFailure()
                }
            }
        }

        stage("Run_System_Tests"){
            steps{
                echo "Running system tests..."
                informGitOnStageStart()
            }
            post{
                success{
                    informGitOnStageSuccess()
                }
                failure{
                    informGitOnStageFailure()
                }
            }
        }

        stage("Deploy_DirPatch"){
            steps{
                echo "Deploying dirpatch..."
                informGitOnStageStart()
            }
            post{
                success{
                    informGitOnStageSuccess()
                }
                failure{
                    informGitOnStageFailure()
                }
            }
        }
    }
    post{
        success{
            dir("dirPatch") {
                    git credentialsId: "fisgo-ci-github", url: "https://github.com/egorsego/dirPatch.git", branch: "master"
            }

            withCredentials([usernamePassword(credentialsId: 'fisgo-ci-github', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                sh """
                    cd dirPatch
                    git remote set-url origin https://${USER}:${PASS}@github.com/egorsego/dirPatch.git
                    touch test4.txt
                    git add .
                    git commit -m "dirPatch dreamkasF 1.26.0"
                    git push origin master
                """

                sh "cd FisGo ; git tag 0.0.8 ; git push origin --tags"


                //git config --local credential.helper "!f() { echo username=\\$USER; echo password=\\$PASS; }; f"
                //git remote set-url origin https://${USER}:${PASS}@github.com/egorsego/dirPatch.git

                //git push https://${USER}:${PASS}@github.com/egorsego/docker-build.git
                //git push origin HEAD:master
                //sh "git tag 1.5"
                //sh "git push origin --tags"
                //git@github.com:egorsego/docker-build.git
                //sh "${env.WORKSPACE}/CI/bash_scripts/tag_creation.sh"
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

String setFisgoVersion() {
    fisgoVerion = sh(returnStdout: true, script:"""
        grep -Po 'fisgo_cur_version = "\\K(.*[0-9])' ${env.WORKSPACE}/FisGo/src/appl/config.h
    """)
    return fisgoVerion
}