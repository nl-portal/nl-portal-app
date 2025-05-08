import org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_21
import java.net.URI

val backendLibrariesVersion = version
val kotlinLoggingVersion by project.properties

plugins {
    kotlin("jvm")
    kotlin("plugin.spring")
    id("org.springframework.boot")
    id("io.spring.dependency-management")
    id("com.github.jk1.dependency-license-report")
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
    maven(URI("https://s01.oss.sonatype.org/content/groups/staging/"))
    maven(URI("https://s01.oss.sonatype.org/content/repositories/snapshots/"))
}

dependencies {
    implementation("nl.nl-portal:case:$backendLibrariesVersion")
    implementation("nl.nl-portal:core:$backendLibrariesVersion")
    implementation("nl.nl-portal:graphql:$backendLibrariesVersion")

    implementation("nl.nl-portal:zaken-api:$backendLibrariesVersion")
    implementation("nl.nl-portal:documenten-api:$backendLibrariesVersion")
    implementation("nl.nl-portal:catalogi-api:$backendLibrariesVersion")
    implementation("nl.nl-portal:objectenapi:$backendLibrariesVersion")

    implementation("nl.nl-portal:berichten:$backendLibrariesVersion")
    implementation("nl.nl-portal:besluiten:$backendLibrariesVersion")
    implementation("nl.nl-portal:form:$backendLibrariesVersion")
    implementation("nl.nl-portal:haalcentraal-all:$backendLibrariesVersion")
    implementation("nl.nl-portal:klant:$backendLibrariesVersion")
    implementation("nl.nl-portal:klant-generiek:$backendLibrariesVersion")
    implementation("nl.nl-portal:klantcontactmomenten:$backendLibrariesVersion")
    implementation("nl.nl-portal:payment:$backendLibrariesVersion")
    implementation("nl.nl-portal:product:$backendLibrariesVersion")
    implementation("nl.nl-portal:taak:$backendLibrariesVersion")

    implementation("org.springframework.boot:spring-boot-starter")
    implementation("io.github.oshai:kotlin-logging:$kotlinLoggingVersion")
    implementation("org.postgresql:postgresql")
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
        )
    )
}
