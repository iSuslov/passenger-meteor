# zuzel/passenger-meteor
Docker image for meteor passenger. Runs meteor in production mode only and does not contain meteor binaries.

#### [github](https://github.com/iSuslov/passenger-meteor) | [dockerhub](https://hub.docker.com/r/zuzel/passenger-meteor/)

## Inside:
 * Latest Phusion Passenger (5.0.28 as for 09 May 2016)
 * Node v0.10.44
 * Everything else you need to run meteor (phantomjs not included)
 * CUPS (Common Unix Printing Server)

## Needed from you:
* Unpackaged meteor bundle.
* Passenger config with meteor enviroment variables. [What gives?](https://www.phusionpassenger.com/library/indepth/environment_variables.html)

## Quick start:

* Unpack meteor bundle to `/some_dir` on your localhost
* Create passenger config `myapp.conf` in `/some_other_dir`

[Example](https://www.phusionpassenger.com/library/walkthroughs/deploy/meteor/ownserver/nginx/oss/trusty/deploy_app.html#edit-nginx-configuration-file) of `myapp.conf`:

```
server {
    listen 80;
    server_name yourserver.com;

    # Tell Nginx and Passenger where your app's 'public' directory is
    root /var/www/my_app_name/public;

    # Turn on Passenger
    passenger_enabled on;
    # Tell Passenger that your app is a Meteor app
    passenger_app_type node;
    passenger_startup_file main.js;

    # Meteor needs sticky sessions
    passenger_sticky_sessions on;

    # Tell your app where MongoDB is
    passenger_env_var MONGO_URL mongodb://mongoserver:27017/myappdb;
    # Tell your app what its root URL is
    passenger_env_var ROOT_URL http://yourserver.com;
}
```
[Full passenger+nginx property reference](https://www.phusionpassenger.com/library/config/nginx/reference)

## Important
Notice how `root` property is defined inside the config file. Passenger needs `public` folder. You should define this property exactly like this, with the exception that `my_app_name` folder can have any name. Don't worry, this docker image will create `public` folder inside unpacked meteor bundle automatically. It will also install all `npm` dependencies. 

## Run 
To start a container:
```
docker run -dit \
    --name=my_meteor_passenger \
    -p 80:80 \
    -v /some_dir/bundle:/var/www/my_app_name \
    -v /some_other_dir/myapp.conf:/etc/nginx/sites-enabled/my_app_name.conf \
    zuzel/passenger-meteor
```


To attach by name: 
```
docker exec -i -t my_meteor_passenger /bin/bash
```

## Troubleshooting
If a container exits immediately after start, double check if you mapped everything (config, bundle dir) correctly. Seriously.