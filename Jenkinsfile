pipeline{
    agent {
        dockerfile {
            filename '.dockerfile'
            label 'fisgo-label-image'
            additionalBuildArgs  '--force-rm'
            args '-t fisgo-name' 
        }
    }
}