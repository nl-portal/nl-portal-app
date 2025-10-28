FROM eclipse-temurin:21-jdk-alpine as build
COPY . .
RUN chmod +x /gradlew
RUN ./gradlew clean bootJar

FROM eclipse-temurin:21-jre-alpine as image
COPY --from=build /build/libs/backend-*.*.*.jar /opt/app.jar

EXPOSE 8080

LABEL org.opencontainers.image.title="NL Portal App Backend" \
      org.opencontainers.image.version="3.0.0-RC" \
      org.opencontainers.image.description="The backend image of the NL Portal App."

ENTRYPOINT ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000", "-jar", "/opt/app.jar"]
