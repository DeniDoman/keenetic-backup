FROM alpine:latest

COPY entrypoint.sh backup.sh /etc/

RUN apk add --update --no-cache openssh sshpass && \
    mkdir /root/.ssh/ && \
    echo "Host *" > /root/.ssh/config && \
    echo "StrictHostKeyChecking no" >> /root/.ssh/config && \
    chmod 400 root/.ssh/config && \
    chmod +x /etc/backup.sh /etc/entrypoint.sh

ENTRYPOINT ["/etc/entrypoint.sh"]