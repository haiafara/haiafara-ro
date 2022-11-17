pipeline {
  environment {
    DATABASE_URL = credentials('database-url')
    RAILS_MASTER_KEY = credentials('rails-master-key')
  }
  agent {
    dockerfile {
      args '-u root -e DATABASE_URL=$DATABASE_URL -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY -e RAILS_ENV=test -e DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL=true --network="host"'
      additionalBuildArgs "-t haiafara-jenkins-build:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
    }
  }
  stages {
    stage('test') {
      steps {
        sh 'bundle exec rails db:test:prepare'
        sh 'ln -s /usr/src/app/node_modules node_modules'
        sh 'bundle exec rails webpacker:compile'
        sh 'sed -i "s/haiafara_test/haiafara_test_$EXECUTOR_NUMBER/g" config/database.yml'
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
