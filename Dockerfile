FROM ubuntu:latest
FROM maven:3.8.5-jdk-8

RUN echo "Prepping Karate" 
RUN pwd

RUN  rm -rf /karate_tests
COPY ne /karate_tests/ne
COPY telus /home/docker/.m2/repository
COPY telus /karate_tests/ne

RUN mkdir /home/app/
RUN chown -R 1001:1001 /home/app/
RUN mkdir /home/app/logs/
RUN chown -R 1001:1001 /home/app/logs/
COPY .git /home/app/.git
COPY src /home/app/src
COPY lib /home/app/lib
COPY pom.xml /home/app
RUN mvn -e -f /home/app/pom.xml clean package -DskipTests


RUN apt-get update

RUN mkdir -p '/home/docker/.m2/repository'

RUN useradd -u 1111 docker \
 && chown -R docker:docker /karate_tests

RUN chown -R docker:docker /home/docker/.m2/repository
RUN ls -ltr /karate_tests/ne/src/test/resources
RUN ls -ltr /karate_tests/ne/dependencies


USER docker:docker 

RUN mvn install:install-file -Dfile=/karate_tests/ne/dependencies/telus-api-test-core-4.1-SNAPSHOT.jar -DpomFile=/karate_tests/ne/dependencies/telus-api-test-core-4.1-SNAPSHOT.pom
RUN mvn install:install-file -Dfile=/karate_tests/ne/dependencies/telus-test-common-core-2.8-SNAPSHOT.jar -DpomFile=/karate_tests/ne/dependencies/telus-test-common-core-2.8-SNAPSHOT.pom
RUN mvn install:install-file -Dfile=/karate_tests/ne/dependencies/frameworks-crypto-7.3.0.jar -DpomFile=/karate_tests/ne/dependencies/frameworks-crypto-7.3.0.pom
RUN mvn install:install-file -Dfile=/karate_tests/ne/dependencies/frameworks-crypto-7.3.0-SNAPSHOT.jar -DpomFile=/karate_tests/ne/dependencies/frameworks-crypto-7.3.0-SNAPSHOT.pom



RUN ls -ltr /home/docker/.m2/repository/telus/bt/automation/telus-api-test-core/4.1-SNAPSHOT
RUN ls -ltr /home/docker/.m2/repository/telus/frameworks/enterprise/frameworks-share/frameworks-crypto/7.3.0

RUN ls -ltr /home/docker/.m2/repository/telus/frameworks/enterprise/frameworks-share/frameworks-crypto/7.3.0-SNAPSHOT


