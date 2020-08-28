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
    
## Credentials file

1. If you want to use the credentials stored in the existing `config/credentials.yml.enc`, retrieve the master key from your password manager, create `config/master.key` and paste the key into it.
2. If you want to create a new credentials file, delete `config/credentials.yml.enc` and run `EDITOR=vim rails credentials:edit`, then use [config/credentials.yml.template](https://github.com/haiafara/haiafara-ro/blob/development/config/credentials.yml.template) as a template. Store the master key in your favorite password manager app.


