FROM eclipse-temurin:11-jre
EXPOSE 8081
ADD target/petclinic.war petclinic.war
ENTRYPOINT ["java","-jar","/petclinic.war"]


