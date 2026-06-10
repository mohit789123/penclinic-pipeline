#stage-1 Builder application
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /petclinic
COPY . .
RUN mvn clean package -DskipTests
#stage-2 runtime
FROM tomcat:9.0-jdk17-openjdk
# Change Tomcat port 8080 -> 8081
RUN sed -i 's/port="8080"/port="8081"/' /usr/local/tomcat/conf/server.xml
WORKDIR /usr/local/tomcat/webapps
RUN rm -rf ROOT
COPY --from=builder /petclinic/target/*.war ./petclinic.war
EXPOSE 8081
CMD ["catalina.sh" , "run"]


