## Install or update Node.js

Ubuntu

    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt install nodejs
    
MacOS

    brew install nodejs

## Install yarn

Ubuntu

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install yarn
    
MacOS

    brew install yarn

## Set up PostgreSQL and PostGIS

Ubuntu

    sudo apt install libpq-dev postgis
    sudo -u postgres createuser <user>
    sudo su - postgres
    psql
    ALTER USER <user> WITH SUPERUSER;

    \c haiafara_production
    CREATE EXTENSION postgis;
    
MacOS

    brew install postgis

## Make a user admin

After registering a user, locally:

    rails users:make_admin[user@email.com]
    
Via Capistrano:

    cap production users:make_admin[user@email.com]
