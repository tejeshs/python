pipeline {
  agent any
  environment {
    BUILD_TAG_SUFFIX = sh(script: 'echo $(date +%Y-%m-%d).$BUILD_NUMBER', returnStdout: true).trim()
    GIT_HASH = GIT_COMMIT.take(7)
    ECR_REPO = credentials('docker')
    EXAMPLE_CREDS = credentials('kubeconfig')

  }
  stages {
    stage('Build') {
      steps {
      sh '''
      rm -rf ~/.kube/config
      [ ! -d -a "~/.kube" ] && mkdir -p ~/.kube
      cp $EXAMPLE_CREDS ~/.kube/config
      aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPO
      docker build -t $ECR_REPO:$BUILD_TAG_SUFFIX-$GIT_HASH .
      docker push $ECR_REPO:$BUILD_TAG_SUFFIX-$GIT_HASH
      kubectl apply -f python.yaml
      kubectl apply -f pythonsvc.yaml
      '''    
      }
    }
  }
}

