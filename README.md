# haiafara.ro

[![Build Status](https://travis-ci.org/haiafara/haiafara-ro.svg?branch=master)](https://travis-ci.org/haiafara/haiafara-ro)
[![View performance data on Skylight](https://badges.skylight.io/status/P2iwuIZhzoOK.svg?token=as0qsqw5qEj8ZXNKBK6c4cmfjRhonMLrqMXkvLh3RQE)](https://www.skylight.io/app/applications/P2iwuIZhzoOK)
[![Waffle.io - Columns and their card count](https://badge.waffle.io/haiafara/haiafara-ro.svg?columns=all)](http://waffle.io/haiafara/haiafara-ro)
[![Gitter chat](https://badges.gitter.im/haiafara/community.png)](https://gitter.im/haiafara/community)

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
