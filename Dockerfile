FROM tomcat:9.0.117-jdk11-temurin
RUN rm -rf /usr/local/tomcat/webapps/ROOT.war
COPY target/petclinic.war /usr/local/tomcat/webapps
EXPOSE 8081
CMD ["catalina.sh" , "run" ]


