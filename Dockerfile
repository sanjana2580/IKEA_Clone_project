FROM tomcat:9-jre9
COPY ./target/css.war /usr/local/tomcat/webapps/
