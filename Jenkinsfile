pipeline {
  environment {
    DATABASE_URL = credentials('database-url')
  }
  agent {
    dockerfile {
      args '-e DATABASE_URL=$DATABASE_URL'
      additionalBuildArgs "-t haiafara-jenkins-build:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
    }
  }
  stages {
    stage('test') {
      steps {
        sh 'bundle exec rails db:setup'
        sh 'bundle exec rspec'
      }   
    }
  }
  /*
  post {
    always {
      echo 'Clean up Docker images'
      sh 'docker rmi --force $(docker images --quiet --filter=reference="jenkins-test-build")'
    }
  }
  */
}
