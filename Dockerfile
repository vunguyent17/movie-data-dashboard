# syntax = docker/dockerfile:1.2
#
# Build stage
#
FROM maven:3.8.3-openjdk-17 AS build
COPY . .
RUN mvn clean package -Pprod -DskipTests

# Package stage
#

FROM eclipse-temurin:17-jdk-focal
COPY --from=build /target/movie-data-dashboard-0.0.1-SNAPSHOT.jar movie-data-dashboard-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "movie-data-dashboard-0.0.1-SNAPSHOT.jar"]

