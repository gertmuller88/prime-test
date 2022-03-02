FROM maven:latest AS build

WORKDIR /
USER root

COPY src /app/prime-test/src
COPY rsrc /app/prime-test/rsrc
COPY pom.xml /app/prime-test/pom.xml

RUN mvn -f /app/prime-test/pom.xml clean package

FROM amazoncorretto:17-alpine AS image
MAINTAINER "Gert Müller | gertmuller88.dev"

WORKDIR /
USER root

COPY --from=build /app/prime-test/target/prime-test.jar /prime-test.jar

EXPOSE 8080

ENV ACTIVE_PROFILE=aws
ENTRYPOINT [ "java",  "-jar", "-Dspring.profiles.active=${ACTIVE_PROFILE}", "/prime-test.jar" ]
