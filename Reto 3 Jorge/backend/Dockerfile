# for ARM:
# FROM arm64v8/eclipse-temurin:24-jre-alpine

# for x86:
FROM eclipse-temurin:24-jre-alpine

COPY /target/*.jar app-estudiantes.jar

CMD ["java", "-jar", "app-estudiantes.jar"]

EXPOSE 8080