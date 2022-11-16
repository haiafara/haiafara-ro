# Dockerfile - Development environment

FROM ruby:2.7.6

RUN apt-get update

# versions
ENV NODE_VERSION=16.18.0
ENV NVM_VERSION=0.39.2
ENV YARN_VERSION=1.22.19

# nodejs via nvm
RUN apt install -y curl
RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# yarn via npm
RUN npm install --global yarn@${YARN_VERSION}

# other dependencies
RUN apt-get install -y postgresql-client
RUN apt-get install -y libexif-dev

# Create and switch to app directory
WORKDIR /usr/src/app

# bundle install
RUN gem install bundler:2.2.26
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --jobs 5

# yarn install
COPY package.json .
COPY yarn.lock .
RUN yarn install
