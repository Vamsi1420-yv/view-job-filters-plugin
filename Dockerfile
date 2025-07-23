# Stage 1: Build the plugin using Maven with Java 17
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy plugin source
COPY . .

# Build the plugin (skipping tests, remove -DskipTests to run them)
RUN mvn -B clean install -DskipTests

# Stage 2: Run Jenkins with the plugin installed
FROM jenkins/jenkins:lts-jdk17

# Preinstall the plugin built in the previous stage
COPY --from=builder /app/target/view-job-filters.hpi /usr/share/jenkins/ref/plugins/view-job-filters.hpi

# Optional: expose Jenkins UI port
EXPOSE 8080
