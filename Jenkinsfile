pipeline {
  agent any

  environment {
    BUILD_TAG_SUFFIX = sh(script: 'echo $(date +%Y-%m-%d).$BUILD_NUMBER', returnStdout: true).trim()
    GIT_HASH = GIT_COMMIT.take(7)
    ECR_REPO = "349381632227.dkr.ecr.us-east-1.amazonaws.com"
  }
  stages {
    stage('Build') {
      steps {
      sh '''
      aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPO
      docker build -t $ECR_REPO:$BUILD_TAG_SUFFIX-$GIT_HASH
      docker push $ECR_REPO:$BUILD_TAG_SUFFIX-$GIT_HASH
      '''     
      }
    }
  }
}

