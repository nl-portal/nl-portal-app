FROM --platform=$BUILDPLATFORM eclipse-temurin:21-jdk-alpine AS build

COPY . .
RUN chmod +x ./gradlew && ./gradlew clean bootJar

FROM eclipse-temurin:21-jre-alpine AS image

# Create non-root user
RUN addgroup -S -g 1001 appgroup && adduser -S -u 1001 -G appgroup -H appuser

# Copy JAR with proper ownership
COPY --chown=1001:1001 --from=build /build/libs/backend-*.*.*.jar /opt/app.jar

# Switch to non-root user
USER 1001

EXPOSE 8080

LABEL org.opencontainers.image.description="NL Portal App Backend."

ENTRYPOINT ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000", "-jar", "/opt/app.jar"]
