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
-> Runs on Alpine so may have some compatiblity issues with some packages/libraries due to c complier


``` 
docker pull debian:buster
```

## Kyma 

