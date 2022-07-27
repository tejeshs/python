pipeline {
  environment {
    BUILD_TAG_SUFFIX = sh(script: 'echo $(date +%Y-%m-%d).$BUILD_NUMBER', returnStdout: true).trim()
    GIT_HASH = GIT_COMMIT.take(7)
  }
  stages {
    stage('Build') {
      sh ' docker image ls '     
    }
  }
}

