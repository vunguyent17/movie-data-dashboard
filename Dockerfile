# syntax = docker/dockerfile:1.2
RUN --mount=type=secret,id=_env,dst=/etc/secrets/.env cat /etc/secrets/.env
#
# Build stage
#
FROM maven:3.8.3-openjdk-17 AS build
COPY . .
RUN mvn clean package -Pprod -DskipTests

#
# Package stage
#

FROM eclipse-temurin:17-jdk-focal
VOLUME /tmp

COPY --from=build /target/movie-data-api-0.0.1-SNAPSHOT.jar movie-data-api-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "movie-data-api-0.0.1-SNAPSHOT.jar"]

