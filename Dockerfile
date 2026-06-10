#stage-1 Builder application
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /petclinic
COPY . .
RUN mvn clean package -DskipTests
#stage-2 runtime
FROM tomcat:9.0-jdk17-openjdk
WORKDIR /usr/local/tomcat/webapps
RUN rm -rf ROOT
COPY --from=builder /petclinic/target/*.war ./petclinic.war
EXPOSE 8080
CMD ["catalina.sh" , "run"]


