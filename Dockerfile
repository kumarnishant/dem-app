FROM maven:3.5-jdk-8-alpine 
#as build
WORKDIR /app
COPY main/pom.xml .
RUN mvn -B -e -C -T 1C org.apache.maven.plugins:maven-dependency-plugin:3.0.2:go-offline
#RUN mvn dependency:go-offline
COPY main/src/ /app/src/
COPY sec/site.css .
RUN ls
#RUN mvn clean package -DskipTests


#FROM openjdk:8-jdk-alpine
#VOLUME /tmp
#COPY --from=build /app/target/demo-app-0.0.1-SNAPSHOT.jar /app/
#EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/demo-app-0.0.1-SNAPSHOT.jar"]
