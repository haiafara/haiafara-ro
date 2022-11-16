pipeline {
  environment {
    DATABASE_URL = credentials('database-url')
    RAILS_MASTER_KEY = credentials('rails-master-key')
  }
  agent {
    dockerfile {
      args '-e DATABASE_URL=$DATABASE_URL -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY'
      additionalBuildArgs "-t haiafara-jenkins-build:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
    }
  }
  stages {
    stage('test') {
      steps {
        sh 'bundle exec rails db:setup RAILS_ENV=test'
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
