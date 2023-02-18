# syntax = docker/dockerfile:1.2
#
# Build stage
#
FROM maven:3.8.3-openjdk-17 AS build
COPY . .
RUN --mount=type=secret,id=env,dst=/etc/secrets/env echo "export DATABASE_NAME=`$(xargs < /etc/secrets/env)`" >> /envfile
RUN . /envfile; echo $DATABASE_NAME
RUN --mount=type=secret,id=env,dst=/etc/secrets/env export $(xargs < env) && echo $DATABASE_NAME && mvn clean package -Pprod -DskipTests

# Package stage
#

FROM eclipse-temurin:17-jdk-focal
COPY --from=build /target/movie-data-api-0.0.1-SNAPSHOT.jar movie-data-api-0.0.1-SNAPSHOT.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "movie-data-api-0.0.1-SNAPSHOT.jar"]

