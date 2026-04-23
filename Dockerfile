#FROM eclipse-temurin:11-jre
#EXPOSE 8081
#ADD target/petclinic.war petclinic.war
#ENTRYPOINT ["java","-jar","/petclinic.war"]
# Use official Tomcat base image with JDK 11
FROM tomcat:9.0-jdk11-openjdk

# Remove default ROOT application to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file into Tomcat's webapps directory
COPY target/petclinic.war /usr/local/tomcat/webapps/petclinic.war

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
