FROM library/alpine:20200917
RUN apk add --no-cache \
    openjdk11-jre-headless=11.0.9_p11-r0

# App user
ARG APP_USER="mindustry"
ARG APP_UID=1368
RUN adduser --disabled-password --uid "$APP_UID" --no-create-home --gecos "$APP_USER" --shell /sbin/nologin "$APP_USER"

# Server binary
ARG APP_VERSION=104.6
ARG APP_BIN="/opt/server.jar"
ADD "https://github.com/Anuken/Mindustry/releases/download/v$APP_VERSION/server-release.jar" "$APP_BIN"
RUN chmod 644 "$APP_BIN"

# Volumes
ARG DATA_DIR="/mindustry"
RUN mkdir "$DATA_DIR" && \
    chown -R "$APP_USER":"$APP_USER" "$DATA_DIR"
VOLUME ["$DATA_DIR"]

#      GAME     STATUS
EXPOSE 6567/udp 6567/tcp

USER "$APP_USER"
WORKDIR "$DATA_DIR"
ENV JAVA_OPT="-Xms8M -Xmx1G"
ENTRYPOINT exec java $JAVA_OPT -jar /opt/server.jar
