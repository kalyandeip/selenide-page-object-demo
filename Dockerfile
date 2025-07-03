# Stage 1: Build the project
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy all files
COPY . .

# Build project and download dependencies (skip tests here, will run in next stage)
RUN mvn clean package -DskipTests

# Stage 2: Run tests in a headless Chrome environment
FROM seleniarm/standalone-chromium:latest

USER root

# Install Java 17 and Maven
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Create work directory
WORKDIR /app

# Copy project from build stage
COPY --from=build /app /app

# Optional: Set headless Chrome via Selenide system properties
ENV SELENIDE_BROWSER=chrome
ENV SELENIDE_HEADLE_
