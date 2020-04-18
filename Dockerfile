FROM confluentinc/cp-kafka-connect-base:3.3.3

MAINTAINER partner-support@confluent.io
LABEL io.confluent.docker=true



RUN echo hello
RUN apt update ; exit 0
RUN apt -y install less vim rsyslog sudo htop
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.0.0-amd64.deb
RUN sudo dpkg -i filebeat-7.0.0-amd64.deb
RUN wget https://raw.githubusercontent.com/logzio/public-certificates/master/COMODORSADomainValidationSecureServerCA.crt
RUN sudo mkdir -p /etc/pki/tls/certs

#as build
WORKDIR /app
COPY main/pom.xml .
RUN mvn -B -e -C -T 1C org.apache.maven.plugins:maven-dependency-plugin:3.0.2:go-offline
#RUN mvn dependency:go-offline
COPY main/src/ /app/src/
COPY sec/site.css .
RUN ls
RUN mvn clean package -DskipTests


#FROM openjdk:8-jdk-alpine
#VOLUME /tmp
#COPY --from=build /app/target/demo-app-0.0.1-SNAPSHOT.jar /app/
#EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/demo-app-0.0.1-SNAPSHOT.jar"]
