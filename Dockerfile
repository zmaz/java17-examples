FROM alpine:3.20.1
RUN apk add openjdk17-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk
ENV PATH=$JAVA_HOME/bin:$PATH
WORKDIR /app
COPY target/java17-examples-0.0.1-SNAPSHOT.jar .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "java17-examples-0.0.1-SNAPSHOT.jar"]
