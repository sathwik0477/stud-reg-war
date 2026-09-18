# Using Tomcat 10.1 with OpenJDK 21 on a slim Debian-based image
FROM tomcat:10.1-jdk21-openjdk-slim

LABEL maintainer="devops-team"
LABEL description="Student Registration App on Tomcat10"

# Best practice: Remove default applications to reduce security footprint
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the build artifact from Maven target directory
# The Jenkins workspace will have the .war file after the 'mvn package' stage
COPY target/*.war /usr/local/tomcat/webapps/student.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

