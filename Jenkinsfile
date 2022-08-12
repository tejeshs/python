pipeline {
  agent any
  environment {
    BUILD_TAG_SUFFIX = sh(script: 'echo $(date +%Y-%m-%d).$BUILD_NUMBER', returnStdout: true).trim()
    GIT_HASH = GIT_COMMIT.take(7)
    ECR_REPO = credentials('docker')
    EXAMPLE_CREDS = credentials('kubeconfig')
    ACCOUNT_ID = credentials('accountid')

  }
  stages {
    stage('Build') {
      steps {
      sh '''
      cp $EXAMPLE_CREDS ~/.kube/config
      aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPO
      docker build -t $ECR_REPO:$BUILD_TAG_SUFFIX-$GIT_HASH .
      docker push $ECR_REPO:$BUILD_TAG_SUFFIX-$GIT_HASH
      '''
      
      sh """
      repo=
      sed -i \'s/BUILD_TAG_SUFFIX/$BUILD_TAG_SUFFIX/g\' python.yaml
      sed -i \'s/GIT_HASH/$GIT_HASH/g\' python.yaml
      sed -i \'s/accountid/$ACCOUNT_ID/g\' python.yaml
      """
      sh '''
      cat python.yaml
      kubectl apply -f python.yaml
      kubectl apply -f pythonsvc.yaml
      '''    
      }
    }
  }
}

