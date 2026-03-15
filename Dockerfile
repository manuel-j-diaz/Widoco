# ----
FROM maven:3.9.14-amazoncorretto-25-alpine AS build_image

WORKDIR /var/build/widoco

COPY . .

RUN mvn package -DskipTests && \
    mv ./JAR/widoco*.jar ./JAR/widoco.jar

# ----
FROM amazoncorretto:25-alpine

RUN apk add --no-cache fontconfig freetype gosu jq

RUN adduser -D widoco
RUN mkdir -p /usr/local/widoco /output
RUN chown -R widoco:widoco /usr/local/widoco /output

WORKDIR /usr/local/widoco

COPY --from=build_image /var/build/widoco/JAR/widoco.jar .
COPY --from=build_image /var/build/widoco/src/main/resources/config ./config
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
