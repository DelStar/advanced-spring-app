# Build Project Using Maven

Maven is a Java-based build tool used to generate executable packages (jar, ear,war) for java based projects.

```bash
mvn clean package
```

## Create Docker Image
Docker is a continerization tool.Using docker we can deploy our applications as 

containers using docker images. Containers contains application code and also the softwares,

config files whatever is required for our application to run.

Create docker image using Dockerfile


```docker
docker build -t daleyhub/advanced-spring-app .
```

## Deploy Application Using Docker Compose 

```docker-compose 
docker-compose up -d 
```

## List Docker Containers
```docker
docker ps -a
```
## License

### [DaleyStar]
=======

