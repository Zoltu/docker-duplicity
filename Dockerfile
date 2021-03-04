FROM alpine:3.13.2

RUN apk add --no-cache duplicity py-boto docker-cli
RUN echo '*/1 * * * * /bin/sh /app/backup.sh' >> /etc/crontabs/backup
RUN chmod 0644 /etc/crontabs/backup
RUN crontab /etc/crontabs/backup
WORKDIR /app
RUN echo 'duplicity ${SOURCE} ${DEST}' >> /app/backup.sh
RUN echo 'duplicity ${DEST} ${SOURCE}' >> /app/restore.sh

VOLUME /root/.cache/duplicity

ENTRYPOINT ["crond", "-f"]

# needed runtime environment variables:
# SOURCE: '/data'
# DEST: 's3://host:port/bucket/'
# AWS_ACCESS_KEY_ID: 'semi-secret'
# AWS_SECRET_ACCESS_KEY: 'secret'
# PASSPHRASE: 'encrypts files'
