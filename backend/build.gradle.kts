import org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_21
import java.net.URI

val backendLibrariesVersion by project.properties
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
    targetCompatibility = JavaVersion.VERSION_21
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
    implementation("nl.nl-portal:common-ground-authentication:$backendLibrariesVersion")
    implementation("nl.nl-portal:graphql:$backendLibrariesVersion")

    implementation("nl.nl-portal:catalogi-api:$backendLibrariesVersion")
    implementation("nl.nl-portal:documenten-api:$backendLibrariesVersion")
    implementation("nl.nl-portal:objectenapi:$backendLibrariesVersion")
    implementation("nl.nl-portal:openklant:$backendLibrariesVersion")
    implementation("nl.nl-portal:zaken-api:$backendLibrariesVersion")
    implementation("nl.nl-portal:payment-direct:$backendLibrariesVersion")
    implementation("nl.nl-portal:haalcentraal-hr:$backendLibrariesVersion")
    implementation("nl.nl-portal:haalcentraal2:$backendLibrariesVersion")

    implementation("nl.nl-portal:berichten:$backendLibrariesVersion")
    implementation("nl.nl-portal:form:$backendLibrariesVersion")
    implementation("nl.nl-portal:taak:$backendLibrariesVersion")
    implementation("nl.nl-portal:besluiten:$backendLibrariesVersion")
    implementation("nl.nl-portal:product:$backendLibrariesVersion")
    implementation("nl.nl-portal:openproduct:$backendLibrariesVersion")

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
    val developmentEnv = mapOf(
        "LOGLEVEL" to "DEBUG",
        "DATABASE_URL" to "jdbc:postgresql://localhost:54321/nl-portal",
    )

    environment.putAll(
        project
            .file("../imports/backend.env")
            .takeIf { it.exists() && it.isFile }
            ?.readLines()
            ?.filterNot { it.startsWith("#") || it.startsWith("//") || it.isEmpty() }
            ?.associate { line ->
                val entry = line.split("=", limit = 2)
                entry.first() to entry.last()
            }
            ?.plus(developmentEnv)
            ?: developmentEnv
    )
}
