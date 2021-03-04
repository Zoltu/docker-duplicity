FROM alpine:3.13.2

RUN apk add --no-cache duplicity py-boto
RUN echo '@daily /bin/sh /app/backup.sh' >> /etc/crontabs/backup
RUN chmod 0644 /etc/crontabs/backup
RUN crontab /etc/crontabs/backup
WORKDIR /app
COPY ./backup.sh /app/backup.sh

VOLUME /root/.cache/duplicity

ENTRYPOINT ["cron", "-f"]
