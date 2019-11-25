pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            label 'fisgo-label-image'
            args '-t fisgo-name'
            additionalBuildArgs  '--force-rm'
        }
    }
}