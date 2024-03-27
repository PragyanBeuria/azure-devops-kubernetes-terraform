# Stage 1: Build stage
FROM maven:3.8.9-jdk-11-slim AS build  # Update Maven and JDK
WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package

# Stage 2: Final stage
FROM openjdk:17-jdk-alpine  # Update to a more recent JDK
VOLUME /tmp
EXPOSE 8000
COPY --from=build /home/app/target/*.jar /app.jar
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar"]
