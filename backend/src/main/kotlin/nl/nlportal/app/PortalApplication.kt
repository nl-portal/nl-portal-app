package nl.nlportal.app

import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.core.env.Environment
import java.net.InetAddress

@SpringBootApplication
class PortalApplication

fun main(args: Array<String>) {
    val applicationContext = runApplication<PortalApplication>(*args)
    val environment: Environment = applicationContext.environment
    val logger = KotlinLogging.logger {}

    logger.info {
        """

        Application '${environment.getProperty("spring.application.name")}' is running!
        Local URL: [http://127.0.0.1:${environment.getProperty("server.port")}].
        External URL: [http://${InetAddress.getLocalHost().hostAddress}:${environment.getProperty("server.port")}]
        """.trimIndent()
    }
}
