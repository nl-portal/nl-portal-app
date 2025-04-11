FROM eclipse-temurin:21-jre-alpine

ADD build/libs/backend-*.*.*.jar /opt/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000", "-jar", "/opt/app.jar"]
