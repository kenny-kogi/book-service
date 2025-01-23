FROM openjdk:21-jdk-slim
VOLUME /tmp
RUN mkdir /application
COPY . /application
WORKDIR /application
ENV TZ="Africa/Nairobi"
COPY gradle /application/gradle
COPY gradlew build.gradle settings.gradle /application/
RUN chmod +x /application/gradlew && /application/gradlew build -x test --scan
RUN mv /application/build/libs/app.jar /application/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/application/app.jar"]