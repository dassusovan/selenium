load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_jvm_external//:specs.bzl", "maven")

def selenium_java_deps():
    netty_version = "4.1.53.Final"
    opentelemetry_version = "0.13.1"

    maven_install(
        artifacts = [
            "com.beust:jcommander:1.78",
            "com.github.javaparser:javaparser-core:3.17.0",
            maven.artifact(
                group = "com.github.spotbugs",
                artifact = "spotbugs",
                version = "4.1.4",
                exclusions = [
                    "org.slf4j:slf4j-api",
                ],
            ),
            "com.google.code.gson:gson:2.8.6",
            "com.google.guava:guava:30.0-jre",
            "com.google.auto:auto-common:0.11",
            "com.google.auto.service:auto-service:1.0-rc7",
            "com.google.auto.service:auto-service-annotations:1.0-rc7",
            "com.graphql-java:graphql-java:15.0",
            "com.typesafe.netty:netty-reactive-streams:2.0.5",
            "io.grpc:grpc-context:1.32.1",
            "io.lettuce:lettuce-core:6.0.1.RELEASE",
            "io.netty:netty-buffer:%s" % netty_version,
            "io.netty:netty-codec-haproxy:%s" % netty_version,
            "io.netty:netty-codec-http:%s" % netty_version,
            "io.netty:netty-codec-http2:%s" % netty_version,
            "io.netty:netty-common:%s" % netty_version,
            "io.netty:netty-handler:%s" % netty_version,
            "io.netty:netty-handler-proxy:%s" % netty_version,
            "io.netty:netty-transport:%s" % netty_version,
            "io.netty:netty-transport-native-epoll:%s" % netty_version,
            "io.netty:netty-transport-native-epoll:jar:linux-x86_64:%s" % netty_version,
            "io.netty:netty-transport-native-kqueue:%s" % netty_version,
            "io.netty:netty-transport-native-kqueue:jar:osx-x86_64:%s" % netty_version,
            "io.netty:netty-transport-native-unix-common:%s" % netty_version,
            "io.opentelemetry:opentelemetry-context:%s" % opentelemetry_version,
             maven.artifact(
                group = "io.opentelemetry",
                artifact = "opentelemetry-api",
                version = "0.13.1",
                exclusions = [
                    "io.opentelemetry:opentelemetry-api-trace",
                    "io.opentelemetry:opentelemetry-api-common",
                    "io.opentelemetry:opentelemetry-context",
                    "io.opentelemetry:opentelemetry-api-baggage",
                ],
            ),
            "io.opentelemetry:opentelemetry-api-baggage:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-api-trace:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-api-common:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-exporter-logging:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-sdk-testing:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-sdk:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-sdk-common:%s" % opentelemetry_version,
            "io.opentelemetry:opentelemetry-sdk-trace:%s" % opentelemetry_version,
            "io.ous:jtoml:2.0.0",
            "it.ozimov:embedded-redis:0.7.3",
            "io.projectreactor:reactor-core:3.4.0",
            "io.projectreactor.netty:reactor-netty:1.0.1",
            "io.projectreactor.netty:reactor-netty-http:1.0.1",
            "javax.servlet:javax.servlet-api:4.0.1",
            maven.artifact(
                group = "junit",
                artifact = "junit",
                version = "4.13.1",
                exclusions = [
                    "org.hamcrest:hamcrest-all",
                    "org.hamcrest:hamcrest-core",
                    "org.hamcrest:hamcrest-library",
                ],
            ),
            "net.bytebuddy:byte-buddy:1.10.18",
            "net.jodah:failsafe:2.4.0",
            "net.sourceforge.htmlunit:htmlunit-core-js:2.45.0",
            "org.apache.commons:commons-exec:1.3",
            "org.assertj:assertj-core:3.18.1",
            "org.asynchttpclient:async-http-client:2.12.1",
            "org.eclipse.mylyn.github:org.eclipse.egit.github.core:2.1.5",
            "org.hamcrest:hamcrest:2.2",
            "org.hsqldb:hsqldb:2.5.1",
            "org.mockito:mockito-core:3.6.0",
            "org.slf4j:slf4j-api:1.7.30",
            "org.slf4j:slf4j-jdk14:1.7.30",
            "org.testng:testng:7.3.0",
            "org.zeromq:jeromq:0.5.2",
            "xyz.rogfam:littleproxy:2.0.0-beta-5",
            "org.seleniumhq.selenium:htmlunit-driver:2.45.0",
        ],
        excluded_artifacts = [
            "org.hamcrest:hamcrest-all",  # Replaced by hamcrest 2
            "org.hamcrest:hamcrest-core",
            "io.netty:netty-all",  # Depend on the actual things you need
            "io.opentelemetry:opentelemetry-api-trace",
            "io.opentelemetry:opentelemetry-api-common",
            "io.opentelemetry:opentelemetry-context",
            "io.opentelemetry:opentelemetry-api-baggage",
        ],
        override_targets = {
            "org.seleniumhq.selenium:selenium-api": "@//java/client/src/org/openqa/selenium:core",
            "org.seleniumhq.selenium:selenium-remote-driver": "@//java/client/src/org/openqa/selenium/remote:remote",
            "org.seleniumhq.selenium:selenium-support": "@//java/client/src/org/openqa/selenium/support",
        },
        fail_on_missing_checksum = True,
        fetch_sources = True,
        strict_visibility = True,
        repositories = [
            "https://jcenter.bintray.com/",
            "https://repo1.maven.org/maven2",
            "https://maven.google.com",
        ],
        maven_install_json = "@selenium//java:maven_install.json",
    )
