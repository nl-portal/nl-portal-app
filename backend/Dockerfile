FROM --platform=$BUILDPLATFORM eclipse-temurin:21-jdk-alpine AS build

COPY . .
RUN chmod +x ./gradlew && ./gradlew clean bootJar

FROM eclipse-temurin:21-jre-alpine AS image

COPY --from=build /build/libs/backend-*.*.*.jar /opt/app.jar

EXPOSE 8080

LABEL org.opencontainers.image.description="NL Portal App Backend."

ENTRYPOINT ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000", "-jar", "/opt/app.jar"]
