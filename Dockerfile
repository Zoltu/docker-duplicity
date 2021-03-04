FROM alpine:edge

RUN apk add --no-cache duplicity py-boto

VOLUME /root/.cache/duplicity

ENTRYPOINT ["duplicity"]
