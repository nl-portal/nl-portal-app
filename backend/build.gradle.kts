import org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_21
import java.net.URI

val backendLibrariesVersion = version
val kotlinLoggingVersion by project.properties

plugins {
    kotlin("jvm")
    kotlin("plugin.spring")
    id("org.springframework.boot")
    id("io.spring.dependency-management")
}

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
    sourceCompatibility = JavaVersion.VERSION_21
}

kotlin {
    compilerOptions {
        jvmTarget = JVM_21
        freeCompilerArgs = listOf("-Xjsr305=strict")
    }
}

repositories {
    mavenCentral()
    maven(URI("https://oss.sonatype.org/content/repositories/releases"))
    maven(URI("https://central.sonatype.com/repository/maven-snapshots/"))
}

dependencies {
    implementation("nl.nl-portal:core:$backendLibrariesVersion")
    implementation("nl.nl-portal:case:$backendLibrariesVersion")
    implementation("nl.nl-portal:common-ground-authentication:$backendLibrariesVersion")
    implementation("nl.nl-portal:graphql:$backendLibrariesVersion")

    implementation("nl.nl-portal:catalogi-api:$backendLibrariesVersion")
    implementation("nl.nl-portal:documenten-api:$backendLibrariesVersion")
    implementation("nl.nl-portal:objectenapi:$backendLibrariesVersion")
    implementation("nl.nl-portal:openklant:$backendLibrariesVersion")
    implementation("nl.nl-portal:zaken-api:$backendLibrariesVersion")
    implementation("nl.nl-portal:payment-direct:$backendLibrariesVersion")
    implementation("nl.nl-portal:haalcentraal2:$backendLibrariesVersion")

    implementation("nl.nl-portal:berichten:$backendLibrariesVersion")
    implementation("nl.nl-portal:form:$backendLibrariesVersion")
    implementation("nl.nl-portal:taak:$backendLibrariesVersion")
    implementation("nl.nl-portal:besluiten:$backendLibrariesVersion")
    implementation("nl.nl-portal:product:$backendLibrariesVersion")

    implementation("org.springframework.boot:spring-boot-starter")
    implementation("org.springframework.boot:spring-boot-starter-actuator")
    implementation("io.github.oshai:kotlin-logging:$kotlinLoggingVersion")
    implementation("org.postgresql:postgresql")

    // CVE-2024-7254
    implementation("com.google.protobuf:protobuf-kotlin:4.31.1")

    // CVE-2025-48924
    implementation("org.apache.commons:commons-lang3:3.18.0")
}

tasks.bootRun {
    environment.putAll(
        mapOf(
            "LOGLEVEL" to "DEBUG",
            "DATABASE_URL" to "jdbc:postgresql://localhost:54321/nl-portal",
            "DATABASE_USERNAME" to "nlportal",
            "DATABASE_PASSWORD" to "password",
            "JWKS_URI" to "http://localhost:8082/auth/realms/nlportal/protocol/openid-connect/certs",
            "KEYCLOAK_CLIENT_ID" to "gzac-portal-m2m",
            "KEYCLOAK_AUDIENCE" to "gzac-portal-token-exchange",
            "KEYCLOAK_TOKEN_EXCHANGE_SECRET" to "ookVRUAxmEWMcosfcGR5nxeoUC4Rgwbc",
        ),
    )
}
