#stage-1 Builder application
FROM maven3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests
#stage-2 runtime
FROM tomcat9.0.117-jdk17-openjdk
WORKDIR /usr/local/tomcat/webapps
RUN rm -rf ROOT
COPY --from=builder /target/petclinic.war ./petclinic.war
EXPOSE 8080
CMD ["catalina.sh" , "run"]


