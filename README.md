# theia-sap-tools 

Example of Eclipse Theia preloaded with common SAP tools. 

[See SAP Tools](https://tools.hana.ondemand.com/)


Other links:  

[theia](https://theia-ide.org/)  
[theia gihub](https://hub.docker.com/r/theiaide/theia)  



## Docker 
```
docker pull theiaide/theia:latest 
docker run --name theia -it -p 3000:3000 -v "$(pwd):/home/project:cached" theiaide/theia 
docker exec -it --user root $(docker ps -aqf name=theia)  /bin/bash 

cat /etc/*-release
```
> Runs on Alpine so may have some compatiblity issues with some packages/libraries due to c complier



Check of Debian Buster as alternative  
``` 
docker pull debian:buster
docker run --name buster -it debian:buster  /bin/bash

apt update 

```

Build Docker image with Debian
```
docker build -t theia-sap-tools .

docker stop theia
docker rm theia

#MAC    Create a folder on local machine to use for theia projects shared with docker at runtime
mkdir "/Users/<user>/Documents/theialocal"
export TheiaPath='/Users/<user>/Documents/theialocal'

docker run --name theia -it -p 3000:3000 -v  "$(echo $TheiaPath):/home/theia/project:cached" theia-sap-tools

```


[Theia running locally](http://localhost:3000/#/home/theia/project)


## Kyma 

