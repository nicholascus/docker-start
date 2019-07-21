This project demonstrates how development environment can be setup with docker, docker compose and make. It works on Windows, Mac and Linux allowing to have build, test and deployment steps to be repeatable across local, CI, test and staging environments. 

Prerequisites:
- on Linux Docker, Docker-compose, make
- on Mac Docker for Mac, make
- on Windows Docker for Windows, git bash, make

Windows would require 

It's heavily inspired by https://3musketeers.io/ but also relies on experience of setting up such projects at work.

to get first experience with the docker based development try:

1. `make` - starts all components of development environment, nginx, node angular development server, php-fpm server and mysql server

2. `make angular-cli` - starts interactive shell in node - angular server container 
    
    1. `npm install` or `ng version` or `ng new tryExampleInTmp --directory ./ --defaults --skip-git`

    2. `exit`

3. `make ps`

```
$ make ps

Name Command State Ports

----------------------------------------------------------------------------------------------------------

sandbox_angular_1 docker-entrypoint.sh ng se ... Up 0.0.0.0:8001->8200/tcp

sandbox_mysql_1 docker-entrypoint.sh mysql ... Up 0.0.0.0:8003->3306/tcp, 33060/tcp

sandbox_nginx_1 nginx -g daemon off; Up 0.0.0.0:8000->80/tcp,0.0.0.0:32774->80/tcp

sandbox_php7fpm_1 docker-php-entrypoint php-fpm Up 0.0.0.0:8002->9000/tcp

sandbox_phpmyadmin_1 /docker-entrypoint.sh apac ... Up 0.0.0.0:8004->80/tcp,0.0.0.0:32775->80/tcp
```


After a little delay pages on the following URLs would be available on your docker host:

http://localhost:8000  - your application served over nginx

http://localhost:8001 - node-angular server 

http://localhost:8000/index.php - single entry point of backend available through nginx


Make-docker-compose configuration allows to spin up frontend containers in custom folders:

1. `make angular-cli AV=tmp/example1/`

2. put you experimental project to tmp/example1 folder or generate new project within `ng new tryExampleInTmp --directory ./ --defaults --skip-git`

3. `ng serve --disableHostCheck --host 0.0.0.0 --port 4200`

4. use parallel session to find local port `make ps`


More detailed workflow and updates for this project are coming soon.
