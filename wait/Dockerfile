FROM ubuntu:latest
RUN apt update && apt install netcat -y && \
    apt install curl -y && \
    apt install jq -y

WORKDIR /
COPY wait.sh /
ENTRYPOINT ["/bin/bash", "wait.sh"]