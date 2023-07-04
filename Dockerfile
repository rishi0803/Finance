FROM openjdk:11
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jars
ENTRYPOINT ["java","-jar","/app.jar"]
