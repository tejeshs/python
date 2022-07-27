pipeline {
  agent any

  environment {
    BUILD_TAG_SUFFIX = sh(script: 'echo $(date +%Y-%m-%d).$BUILD_NUMBER', returnStdout: true).trim()
    GIT_HASH = GIT_COMMIT.take(7)
  }
  stages {
    stage('Build') {
      steps {
      docker build -t python-docker .
      docker run -d -p 3000:3000 python-docker
      '''     
      }
    }
  }
}

