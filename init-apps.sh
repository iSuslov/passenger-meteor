#!/bin/bash
for dir in /var/www/*
        do if [ -d $dir ]
        then
                cd $dir
                mkdir public
                cd programs/server
                npm install
        fi
done

nginx -g "daemon off;"
