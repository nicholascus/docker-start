This project allows to setup php angular mysql based project development on docker.
It's heavily inspered by https://3musketeers.io/ but also relies on experience of setting up such projects at work.

to get first experience with the docker based development try:
1. make
2. make angular-cli
   1.
   2. exit
3. make ps
   $ make ps
        Name                      Command               State                     Ports
----------------------------------------------------------------------------------------------------------
sandbox_angular_1      docker-entrypoint.sh ng se ...   Up      0.0.0.0:8001->8200/tcp
sandbox_mysql_1        docker-entrypoint.sh mysql ...   Up      0.0.0.0:8003->3306/tcp, 33060/tcp
sandbox_nginx_1        nginx -g daemon off;             Up      0.0.0.0:8000->80/tcp,0.0.0.0:32774->80/tcp
sandbox_php7fpm_1      docker-php-entrypoint php-fpm    Up      0.0.0.0:8002->9000/tcp
sandbox_phpmyadmin_1   /docker-entrypoint.sh apac ...   Up      0.0.0.0:8004->80/tcp,0.0.0.0:32775->80/tcp

After a little delay all following URL would be available for you:
http://localhost:8000
http://localhost:8001
http://localhost:8000/index.php

One of the features of this project setup is configuration parameter allowing to quickly spin up containers with frontend with code in tmp folder
1. make angular-cli AV=tmp/example1/
   1. put you experimental project to tmp/example1 folder or generate new project with `ng new tryExampleInTmp --directory ./ --defaults --skip-git`
   2. ng serve --disableHostCheck --host 0.0.0.0 --port 4200
2. use parallel session to find local port `make ps`


More detailed workflow and updates for this project are comming soon. There will be article, extensions with other backend and optimisations of base docker images.
