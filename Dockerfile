FROM tomcat:9.0.117-jdk11-temurin
RUN rm -rf /usr/local/tomcat/webapps/ROOT*
COPY target/petclinic.war /usr/local/tomcat/webapps/petclinic.war
EXPOSE 8080
CMD ["catalina.sh" , "run" ]


