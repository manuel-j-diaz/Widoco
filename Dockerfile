# ----
FROM maven:3.9.9-eclipse-temurin-17 AS build_image

WORKDIR /var/build/widoco

COPY . .

RUN mvn package -DskipTests && \
    mv ./JAR/widoco*.jar ./JAR/widoco.jar

# ----
FROM eclipse-temurin:17-jre

RUN apt-get update && apt-get install -y libfreetype6 fontconfig gosu jq

RUN useradd widoco
RUN mkdir -p /usr/local/widoco /output
RUN chown -R widoco:widoco /usr/local/widoco /output

WORKDIR /usr/local/widoco

COPY --from=build_image /var/build/widoco/JAR/widoco.jar .
COPY --from=build_image /var/build/widoco/src/main/resources/config ./config
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
