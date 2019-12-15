FROM openjdk:8
ADD target/ticket-0.0.1-SNAPSHOT.jar ticket-1.0.0.jar
ENTRYPOINT ["java", "-jar", "ticket-1.0.0.jar"]