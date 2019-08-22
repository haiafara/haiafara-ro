## Make a user admin

After registering a user, locally run:

    rails users:make_admin[user@email.com]
    
Or via Capistrano:

    cap production users:make_admin[user@email.com]
