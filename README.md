# haiafara.ro

[![Build Status](https://travis-ci.org/haiafara/haiafara-ro.svg?branch=master)](https://travis-ci.org/haiafara/haiafara-ro)

## Install or update Node.js

    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt install nodejs

## Install yarn

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install yarn

## Set up PostgreSQL and PostGIS

    sudo apt install libpq-dev postgis
    sudo -u postgres createuser <user>
    sudo su - postgres
    psql
    ALTER USER <user> WITH SUPERUSER;

    \c haiafara_production
    CREATE EXTENSION postgis;

## Run in production mode locally

    RAILS_ENV=production rails assets:precompile; RAILS_ENV=production rails s
