# Build Project Using Maven

Maven is a Java-based build tool used to generate executable packages (jar, ear,war) for java based projects.

```bash
mvn clean package
```

## Create Docker Image
Docker is a containerization tool. Using Docker, we can deploy our applications as containers using Docker images. Containers contain application code as well as the necessary software and configuration files required for our application to run.

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

